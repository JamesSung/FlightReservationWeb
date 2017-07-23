package com.james.ctrl;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.validation.Valid;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import com.james.bo.Airport;
import com.james.bo.Booking;
import com.james.bo.Flight;
import com.james.bo.User;
import com.james.service.BookingService;
import com.james.service.EntityMgmtService;

@Controller
public class BookingController extends WebMvcConfigurerAdapter{

    @Autowired
    BookingService bookingService;
    
    @Autowired
    EntityMgmtService entityMgmtService;
    
    @Autowired
    Logger logger;

    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, false));
    }
    
    @RequestMapping("/searchFlight")
    public String searchFlight(@RequestParam(value="departure", defaultValue="all") String departure, 
    		@RequestParam(value="arrival", defaultValue="all") String arrival,
    		@RequestParam(value="departureDate",  required=false, defaultValue="07/01/2017") Date departureDate,
    		@RequestParam(value="returnDate",  required=false, defaultValue="07/30/2017") Date returnDate,
    		Model model) {
    	
    	Date curr = new Date(System.currentTimeMillis());
    	
    	if(departureDate.before(curr))
    		departureDate = curr; 
    	
    	if(returnDate.before(curr)){
        	Calendar cal = Calendar.getInstance();
        	cal.setTime(departureDate);
        	cal.add(Calendar.DAY_OF_MONTH, 10);
        	returnDate = cal.getTime();
    	}
    	
    	//It's going to display all the flights departing between departureDate and returnDate.
    	List<Flight> fls = bookingService.findFlightsByDepartureAndArrivalAndDepartureDateBetween(departure, arrival, departureDate, returnDate, true);

		//for the select options
    	List<Airport> ars = bookingService.findAllAirports();
    	
        model.addAttribute("airportList", ars);
        model.addAttribute("flightList", fls);
        model.addAttribute("departure", departure);
        model.addAttribute("arrival", arrival);
        model.addAttribute("departureDate", departureDate);
        model.addAttribute("returnDate", returnDate);
        
        return "searchFlight";
    }

    @RequestMapping(value = "/confirmBooking", method = RequestMethod.POST)
    public String confirmBooking(@RequestParam(value="id") List<String> ids, Model model) {
    	
    	List<Flight> fls = new ArrayList<Flight>();
    	for(String id: ids){
    		fls.add(bookingService.findFlightById(id));
    	}

        model.addAttribute("flightList", fls);
        return "confirmBooking";
    }

    @RequestMapping(value = "/addBooking", method = RequestMethod.POST)
    public String addBooking(@ModelAttribute Booking booking, @RequestParam(value="flightid") List<String> flightids, Model model, HttpServletRequest request) throws Exception{
    	    	
    	List<Flight> fls = new ArrayList<Flight>();
    	for(String id: flightids){
    		fls.add(bookingService.findFlightById(id));
    	}
    	
    	if(booking.getBooker() == null || "".equals(booking.getBooker())){
    		if(request.getSession() != null){
    	    	User user = bookingService.findUserByEmail((String)request.getSession().getAttribute("email"));
    			booking.setBooker(user.getEmail());
    	    	booking.setPassword(user.getPassword());
    		}
    	}
    	
    	booking.setBookDate(new Date(System.currentTimeMillis()));
    	booking.setFlights(fls);
    	
    	if(logger.isDebugEnabled()){
    		logger.debug("BookingController.addBooking: " + booking);
    	}
    	
    	entityMgmtService.createBooking(booking);
    	
    	model.addAttribute("booker", booking.getBooker());
    	model.addAttribute("password", booking.getPassword());

        return "redirect:bookingList";
    }
    
    @RequestMapping(value = "/bookingList", method = {RequestMethod.GET, RequestMethod.POST})
    public String bookingList(String booker, String password, Model model, HttpServletRequest request) {
    	
    	String email = (String)request.getSession().getAttribute("email");
    	System.out.println(email);

    	if(booker == null && email == null)  return "bookingList";

    	List<Booking> bks = email != null ?
    			bookingService.findBookingsByBooker(email)
    			: bookingService.findBookingsByBookerAndPassword(booker, password);
    	System.out.println(bks);
    	if(logger.isDebugEnabled()){
    		logger.debug("BookingController.bookingList: " + bks);
    	}    	
        model.addAttribute("bookingList", bks);
    	model.addAttribute("booker", booker);
    	model.addAttribute("password", password);
        
        return "bookingList";
    }

    @RequestMapping(value = "/signup", method = {RequestMethod.GET})
    public String signup(User userForm, Model model) {
    	model.addAttribute("userForm", new User());
        return "signup.html";
    }
    
    @RequestMapping(value = "/signup", method = {RequestMethod.POST})
    public String signupConfirm(@ModelAttribute("userForm") @Valid User userForm, BindingResult bindingResult, Model model) {
    	
        if (bindingResult.hasErrors()) {
            return "signup.html";
        }
        
    	entityMgmtService.createUser(userForm);
    	
        return "redirect:login";
    }
    
    @RequestMapping(value = "/login", method = {RequestMethod.GET})
    public String login() {
        
        return "login";
    }
    
    @RequestMapping(value = "/loginConfirm", method = {RequestMethod.POST})
    public String loginConfirm(String email, String password, HttpServletRequest request, Model model) {
    	
    	User user = bookingService.findUserByEmail(email);
    	System.out.println(user);
    	if(user == null || !user.getPassword().equals(password)){
	    	model.addAttribute("msg", "Userid or password doesn't match!");
	        return "message";  
    	}
    	
    	request.getSession().setAttribute("email",email);
    	request.getSession().setAttribute("name",user.getFirstName());
    	request.getSession().setAttribute("admin",user.isIsAdmin());
        
        return "redirect:searchFlight";//"greeting";
    }

    @RequestMapping(value = "/greeting", method = {RequestMethod.POST})
    public String greeting(String email, String name, HttpServletRequest request, Model model) {
    	
    	User user = bookingService.findUserByEmail(email);
    	if(user == null && name != null){//first fb login
    		String[] names = name.split(" ");
    		String passwd = names[0];
    		User newUser = new User();
    		newUser.setEmail(email);
    		newUser.setPassword(passwd);
    		newUser.setFirstName(names[0]);
    		if(names.length > 1)
    			newUser.setLastName(names[names.length-1]);
    		
    		entityMgmtService.createUser(newUser);
    		user = newUser;
    		
    	}
    	
    	request.getSession().setAttribute("email",email);
    	request.getSession().setAttribute("name",name);
    	request.getSession().setAttribute("admin",user.isIsAdmin());
        
        return "redirect:searchFlight";//"greeting";
    }
    
    @RequestMapping(value = "/logout", method = {RequestMethod.GET})
    public String logout(HttpSession session, Model model) {
    	
    	session.invalidate();
    	model.addAttribute("msg", "You've been logged out successfully!");
        return "message";
    }
    
    
}

package com.james.ctrl;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.james.bo.Airport;
import com.james.bo.Flight;
import com.james.service.BookingService;
import com.james.service.EntityMgmtService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
    @Autowired
    EntityMgmtService entityMgmtService;
    
    @Autowired
    BookingService bookingService;
    
    @Autowired
    Logger logger;

    @RequestMapping("/airport")
    public String airport(@RequestParam(value="city", required=false, defaultValue="Toronto") String city, Model model) {
    	List<Airport> ars =  "all".equals(city) ?   bookingService.findAllAirports() : bookingService.findAirportsByCity(city);
    	
    	if(logger.isDebugEnabled()){
    		logger.debug("BookingController.airport: ");
    		logger.debug("city: " + city);
	    	for(Airport ar : ars){
	    		logger.debug(ar);
	    	}
    	}
    	
    	model.addAttribute("airportList", ars);
    	model.addAttribute("city", city);
        return "admin/airport";
    }

    @RequestMapping("/flight")
    public String flight(@RequestParam(value="departure", required=false, defaultValue="YYZ") String departure, 
    		@RequestParam(value="arrival", required=false, defaultValue="JFK") String arrival,
    		@RequestParam(value="departureDate", required=false) Date departureDate,
    		Model model) {
    	
    	List<Flight> fls;
    	if("all".equals(departure)){
    		fls = bookingService.findAllFlights();
    	}else{
    	 
	    	if(departureDate == null)
	    		departureDate = new Date(System.currentTimeMillis());
	    	
	    	Calendar cal = Calendar.getInstance();
	    	cal.setTime(departureDate);
	    	cal.add(Calendar.DAY_OF_MONTH, -3);
	    	Date from = cal.getTime();
	    	cal.add(Calendar.DAY_OF_MONTH, 6);
	    	Date to = cal.getTime();
	    	
	    	fls = bookingService.findFlightsByDepartureAndArrivalAndDepartureDateBetween(departure, arrival, from, to, false);
    	}
    	
    	if(logger.isDebugEnabled()){
    		logger.debug("BookingController.flight: ");
    		logger.debug("departure: " + departure + ", arrival: " + arrival);
	    	for(Flight fl : fls){
	    		logger.debug(fl);
	    	}
    	}    	
        model.addAttribute("flightList", fls);
        model.addAttribute("departure", departure);
        model.addAttribute("arrival", arrival);
        model.addAttribute("departureDate", departureDate);
        return "admin/flight";
    }

    @RequestMapping(value = "/addAirport", method = RequestMethod.POST)
    public String addAirport(@ModelAttribute Airport airport, String city, Model model) {
    	
    	if(logger.isDebugEnabled()){
    		logger.debug("AdminController.addAirport: " + airport);
    	}
    	
    	entityMgmtService.createAirport(airport);
    	
    	model.addAttribute("city", city);

    	return "redirect:airport";
    }
    
    @RequestMapping(value = "/deleteAirport", method = RequestMethod.POST)
    public String deleteAirport(@ModelAttribute Airport airport, String city, Model model) {
    	
    	if(logger.isDebugEnabled()){
    		logger.debug("AdminController.deleteAirport: " + airport);
    	}

    	entityMgmtService.removeAirport(airport);
    	
    	model.addAttribute("city", city);

    	return "redirect:airport";
    }

    @RequestMapping(value = "/addFlight", method = RequestMethod.POST)
    public String addFlight(@ModelAttribute Flight flight, Model model) {
    	
    	if(logger.isDebugEnabled()){
    		logger.debug("AdminController.addFlight: " + flight);
    	}
    	
    	entityMgmtService.createFlight(flight);
    	
    	model.addAttribute("departure", flight.getDeparture().getCode());
    	model.addAttribute("arrival", flight.getArrival().getCode());
    	model.addAttribute("departureDate", flight.getDepartureDate());

        return "redirect:flight";
    }
    
    @RequestMapping(value = "/deleteFlight", method = RequestMethod.POST)
    public String deleteFlight(@ModelAttribute Flight flight, Model model) {
    	
    	if(logger.isDebugEnabled()){
    		logger.debug("AdminController.deleteFlight: " + flight);
    	}
    	
    	entityMgmtService.removeFlight(flight);
    	
    	model.addAttribute("departure", flight.getDeparture().getCode());
    	model.addAttribute("arrival", flight.getArrival().getCode());
    	model.addAttribute("departureDate", flight.getDepartureDate());

        return "redirect:flight";
    }
}

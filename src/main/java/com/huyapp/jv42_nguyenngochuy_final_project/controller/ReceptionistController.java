/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.huyapp.jv42_nguyenngochuy_final_project.controller;

import com.huyapp.jv42_nguyenngochuy_final_project.entities.BookingDetailEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.BookingEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.PromotionEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.RoomEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.ServiceBookingEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.ServiceEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.enums.RoomStatus;
import com.huyapp.jv42_nguyenngochuy_final_project.service.ConvenientService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.PromotionService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.RoomService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.RoomTypeService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.ServiceBookingService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.ServiceService;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/receptionist")
public class ReceptionistController {

    @Autowired
    private RoomService roomService;
    
    @Autowired
    private RoomTypeService roomTypeService;
    
    @Autowired
    private ServiceService serviceService;
    
    @Autowired
    private ServiceBookingService serviceBookingService;
    
    @Autowired
    private PromotionService promotionService;
    
    @Autowired
    private ConvenientService convenientService;
    
    @RequestMapping("/index")
    public String viewHome(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("message", "Hello Receptionist: " + username);
        return "receptionist/index";
    }
    
//    @RequestMapping(value = {"/booking-now"}, method = RequestMethod.GET)
//    public String viewAvailableRooms(ModelMap model,
//            HttpSession session) {
//        
//        HashMap<Long, BookingEntity> bookingItems = (HashMap<Long, BookingEntity>) session.getAttribute("myBookingItems");
//        if (bookingItems == null) {
//            bookingItems = new HashMap<>();
//        }
//        BookingEntity booking = new BookingEntity();
//        session.setAttribute("myBookingItems", booking);
//        return "receptionist/booking";
//
//    }
    
    @RequestMapping(value = {"/view-available-rooms"}, method = RequestMethod.GET)
    public String viewAvailableRooms(Model model,
//            HttpSession session,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
    // Save list of rooms
        List<RoomEntity> rooms = roomService.getAvailableRooms();
        // Get roomtypes name of rooms
        for(int i = 0; i < rooms.size(); i++) {
            rooms.get(i).setRoomType(roomTypeService.searchRoomTypeByRoomId(rooms.get(i).getId()));
        }
        // Get list of images of rooms
        for(int i = 0; i < rooms.size(); i++) {
            rooms.get(i).setImages(roomTypeService.searchRoomTypeByRoomId(rooms.get(i).getId()).getImages());
        }
        // Get list of convenients of rooms
        for(int i = 0; i < rooms.size(); i++) {
            rooms.get(i).setConvenients(convenientService.searchConvenients(roomTypeService.searchRoomTypeByRoomId(rooms.get(i).getId()).getId()));
        }
        // Get a discount from promotions of rooms
        LocalDate today = LocalDate.now();
        LocalDate tomorrow = today.plusDays(1);
        for(int i = 0; i < rooms.size(); i++) {
            List<PromotionEntity> promos = promotionService.searchPromotionAvailable(roomTypeService.searchRoomTypeByRoomId(rooms.get(i).getId()).getId(),today);
            rooms.get(i).setDiscounts(promos);
        }
        model.addAttribute("rooms", rooms);
        // Save list of available services
        model.addAttribute("services", serviceService.getAvailableServices());
        
        // Others
        model.addAttribute("tomorrow", tomorrow);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "receptionist/view-available-rooms";

    }
    
    @RequestMapping(value = "/booking/{roomId}", method = RequestMethod.GET)
    public String booking(ModelMap model,
            HttpSession session,
            @PathVariable(name = "roomId", required = false) int roomId) {
        HashMap<Integer, BookingDetailEntity> bookingDetailItems = (HashMap<Integer, BookingDetailEntity>) session.getAttribute("myBookingDetailItems");
        if (bookingDetailItems == null) {
            bookingDetailItems = new HashMap<>();
        }
        RoomEntity room = roomService.findById(roomId);
        // Get list of room type name
        room.setRoomType(roomTypeService.searchRoomTypeByRoomId(room.getId()));
        // Get list of image name
        room.setImages(roomTypeService.searchRoomTypeByRoomId(room.getId()).getImages());
        // Get a discount from promotions
        LocalDate today = LocalDate.now();
        double discount = 0;
        List<PromotionEntity> promos = promotionService.searchPromotion(roomTypeService.searchRoomTypeByRoomId(room.getId()).getId());
        for (int i = 0; i < promos.size(); i++) {
            if(today.isAfter(promos.get(i).getCreateDate()) && today.isBefore(promos.get(i).getEndDate())) {
                discount = promos.get(i).getDiscount();
            }
        }
        //
        List<ServiceEntity> services = serviceService.getServices();
        List<ServiceBookingEntity> serviceBookings = serviceBookingService.getServiceBookings();
        // Setup for item booking
        if (room != null) {
            if (bookingDetailItems.containsKey(roomId)) {
                BookingDetailEntity item = bookingDetailItems.get(roomId);
                item.setRoom(room);
                item.setDiscount(discount);
                item.setPrice(room.getPrice());
                bookingDetailItems.put(roomId, item);
            } else {
                BookingDetailEntity item = new BookingDetailEntity();
                item.setRoom(room);
                item.setDiscount(discount);
                item.setPrice(room.getPrice());
                bookingDetailItems.put(roomId, item);
                
            }
        }
        
        List<ServiceEntity> serviceItems = serviceService.getServices();
        
        session.setAttribute("myBookingDetailItems", bookingDetailItems);
        session.setAttribute("myServiceItems", serviceItems);
        session.setAttribute("myBookingDetailTotal", totalPrice(bookingDetailItems));
        session.setAttribute("myBookingNum", bookingDetailItems.size());
        session.setAttribute("today", today);
        return "redirect:/booking";
    }
    
    @RequestMapping("/booking")
    public String showBooking(HttpSession session){
        HashMap<Integer, BookingDetailEntity> bookingDetailItems = (HashMap<Integer, BookingDetailEntity>) session.getAttribute("myBookingDetailItems");
        return "booking";
    }
    
    public double totalPrice(HashMap<Integer, BookingDetailEntity> bookingDetailItems) {
        int count = 0;
        for (Map.Entry<Integer, BookingDetailEntity> list : bookingDetailItems.entrySet()) {
            count += list.getValue().getRoom().getPrice() * (1 - list.getValue().getDiscount()/100);
        }
        return count;
    }
}

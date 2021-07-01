/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.huyapp.jv42_nguyenngochuy_final_project.controller;

import com.huyapp.jv42_nguyenngochuy_final_project.entities.ConvenientEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.PromotionEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.RoomEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.RoomTypeEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.ServiceEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.enums.PromotionStatus;
import com.huyapp.jv42_nguyenngochuy_final_project.enums.RoomStatus;
import com.huyapp.jv42_nguyenngochuy_final_project.enums.ServiceStatus;
import com.huyapp.jv42_nguyenngochuy_final_project.service.ConvenientService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.ImageService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.PromotionService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.RoomService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.RoomTypeService;
import com.huyapp.jv42_nguyenngochuy_final_project.service.ServiceService;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
@RequestMapping("/manager")
public class ManagerController {

    @Autowired
    private PromotionService promotionService;
    
    @Autowired
    private ConvenientService convenientService;
    
    @Autowired
    private RoomTypeService roomTypeService;
    
    @Autowired
    private RoomService roomService;
    
    @Autowired
    private ImageService imageService;
    
    @Autowired
    private ServiceService serviceService;
    
    @InitBinder
    public void initBinder(WebDataBinder dataBinder) {
        StringTrimmerEditor stringTrimmerEditor = new StringTrimmerEditor(true);
        dataBinder.registerCustomEditor(String.class, stringTrimmerEditor);
    }
    
    @RequestMapping("/index")
    public String viewHome(Model model) {

        Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();
        String username = principal.toString();
        if (principal instanceof UserDetails) {
            username = ((UserDetails) principal).getUsername();
        }

        model.addAttribute("message", "Hello Manager: " + username);
        return "manager/index";
    }
    
    
// RoomType controllers
    @RequestMapping("/roomtype-add")
    public String addRoomType(Model model) {
        model.addAttribute("roomtype", new RoomTypeEntity());
        model.addAttribute("status", RoomStatus.values());
//        model.addAttribute("promotions", promotionService.getPromotions());
        model.addAttribute("convenients", convenientService.getConvenients());
        model.addAttribute("action", "add");

        return "manager/roomtype-add";
    }
    
    @RequestMapping("/roomtype-edit/{roomtypeId}")
    public String editRoomType(Model model,
            @PathVariable("roomtypeId") int roomtypeId) {
        model.addAttribute("roomtype", roomTypeService.findById(roomtypeId));
        model.addAttribute("status", RoomStatus.values());
        List<ConvenientEntity> convenientOfRoomTypes = convenientService.searchConvenients(roomtypeId);        
        List<ConvenientEntity> convenients = convenientService.getConvenients();
        for(int i = 0; i < convenients.size(); i++) {
            for(int j = 0; j < convenientOfRoomTypes.size(); j++) {
                if(convenients.get(i).getName().equals(convenientOfRoomTypes.get(j).getName())) {
                    convenients.get(i).setChecked(true);
                    break;
                } else
                    convenients.get(i).setChecked(false);
            }
        }
        model.addAttribute("convenients", convenients);
        model.addAttribute("action", "edit");
        return "manager/roomtype-add";
    }
    
    @RequestMapping(value = "/result-roomtype", method = RequestMethod.POST)
    public String resultroomtype(Model model,
            @Valid @ModelAttribute("roomtype") RoomTypeEntity roomtype,
            HttpServletRequest request) {
        
            if (roomtype.getImagesUpload() != null && roomtype.getImagesUpload().length > 0) {
                roomtype.setImages(imageService.uploadImageToRoomType(roomtype.getImagesUpload(), request, roomtype));
            }
            
            // Save list of promotions
//            List<PromotionEntity> promotions = new ArrayList<>();
//            for(int i = 0; i < roomtype.getPromotionsId().size(); i++) {
//                promotions.add(promotionService.findById(roomtype.getPromotionsId().get(i)));
//            }
//            roomtype.setPromotions(promotions);
            
            // Save list of convenients
            List<ConvenientEntity> convenients = new ArrayList<>();
            for(int i = 0; i < roomtype.getConvenientsId().size(); i++) {
                convenients.add(convenientService.findById(roomtype.getConvenientsId().get(i)));
            }
            roomtype.setConvenients(convenients);
            
            roomTypeService.save(roomtype);
            return "redirect:/manager/view-roomtypes";
        
    }
    
    @RequestMapping(value = {"/view-roomtypes"}, method = RequestMethod.GET)
    public String viewRoomTypes(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        model.addAttribute("roomtypes", roomTypeService.getRoomTypes());
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "manager/view-roomtypes";

    }
    
    // Remove image from roomtype
    @RequestMapping("/deleteImageFromRoomType/{imageId}")
    public String deleteImage(Model model,
            @PathVariable("imageId") int imageId) {
        imageService.deleteImage(imageId);
        if (imageService.deleteImage(imageId)) {
            return "redirect:/manager/view-roomtypes?type=error&message=Delete Image Id: " + imageId + " Fail!!!";
        } else {
            return "redirect:/manager/view-roomtypes?type=success&message=Delete Image Id: " + imageId + " success!!!";
        }
    }
    
    @RequestMapping("/roomtype-delete/{roomtypeId}")
    public String deleteRoomType(Model model,
            @PathVariable("roomtypeId") int roomtypeId) {
        if (roomTypeService.deleteRoomType(roomtypeId)) {
            return "redirect:/manager/view-roomtypes?type=error&message=Delete Room Type Id: " + roomtypeId + " Fail!!!";
        } else {
            return "redirect:/manager/view-roomtypes?type=success&message=Delete Room Type Id: " + roomtypeId + " success!!!";
        }
    }
// End of RoomType controllers
    
// Room controllers
    @RequestMapping("/room-add")
    public String addRoom(Model model) {
        model.addAttribute("room", new RoomEntity());
        model.addAttribute("status", RoomStatus.values());
        model.addAttribute("roomtypes", roomTypeService.getRoomTypes());
        model.addAttribute("action", "add");

        return "manager/room-add";
    }
    
    @RequestMapping("/room-edit/{roomId}")
    public String editRoom(Model model,
            @PathVariable("roomId") int roomId) {
        RoomEntity room = roomService.findById(roomId);
        // Get room type name
        room.setRoomType(roomTypeService.searchRoomTypeByRoomId(room.getId()));
        
        model.addAttribute("room", room);
        model.addAttribute("status", RoomStatus.values());
        model.addAttribute("roomtypes", roomTypeService.getRoomTypes());
        model.addAttribute("action", "edit");
        
        return "manager/room-add";
    }
    
    @RequestMapping(value = "/result-room", method = RequestMethod.POST)
    public String resultroom(Model model,
            @Valid  @ModelAttribute("room") RoomEntity room) {
        roomService.save(room);
        return "redirect:/manager/view-rooms";
    }
    
    @RequestMapping(value = {"/view-rooms"}, method = RequestMethod.GET)
    public String viewRooms(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        // Save list of roomtype
        List<RoomEntity> rooms = roomService.getRooms();
        for(int i = 0; i < rooms.size(); i++) {
            rooms.get(i).setRoomType(roomTypeService.searchRoomTypeByRoomId(rooms.get(i).getId()));
        }
        model.addAttribute("rooms", rooms);
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "manager/view-rooms";

    }
    
    @RequestMapping("/room-delete/{roomId}")
    public String deleteRoom(Model model,
            @PathVariable("roomId") int roomId) {
        if (roomService.deleteRoom(roomId)) {
            return "redirect:/manager/view-rooms?type=error&message=Delete Room Id: " + roomId + " Fail!!!";
        } else {
            return "redirect:/manager/view-rooms?type=success&message=Delete Room Id: " + roomId + " success!!!";
        }
    }
    
// End of Room controllers
    
// Promotion controllers
    @RequestMapping("/promotion-add")
    public String addPromotion(Model model) {
        model.addAttribute("promotion", new PromotionEntity());
        model.addAttribute("status", PromotionStatus.values());
        model.addAttribute("roomtypes", roomTypeService.getRoomTypes());
        model.addAttribute("today",LocalDate.now());
        model.addAttribute("action", "add");
        return "manager/promotion-add";
    }
    
    @RequestMapping("/promotion-edit/{promotionId}")
    public String editPromotion(Model model,
            @PathVariable("promotionId") int promotionId) {
        model.addAttribute("promotion", promotionService.findById(promotionId));
        model.addAttribute("status", PromotionStatus.values());
        List<RoomTypeEntity> roomtypesOfPromotions = roomTypeService.searchRoomTypes(promotionId);        
        List<RoomTypeEntity> roomtypes = roomTypeService.getRoomTypes();
        for(int i = 0; i < roomtypes.size(); i++) {
            for(int j = 0; j < roomtypesOfPromotions.size(); j++) {
                if(roomtypes.get(i).getName().equals(roomtypesOfPromotions.get(j).getName())) {
                    roomtypes.get(i).setChecked(true);
                    break;
                } else
                    roomtypes.get(i).setChecked(false);
            }
        }
        model.addAttribute("roomtypes", roomtypes);
        model.addAttribute("action", "edit");
        return "manager/promotion-add";
    }
    
    @RequestMapping(value = "/result-promotion", method = RequestMethod.POST)
    public String resultPromotion(Model model,
            @Valid  @ModelAttribute("promotion") PromotionEntity promotion) {
        // Save list of promotions
        List<RoomTypeEntity> roomtypes = new ArrayList<>();
        for(int i = 0; i < promotion.getRoomtypesId().size(); i++) {
            roomtypes.add(roomTypeService.findById(promotion.getRoomtypesId().get(i)));
        }
        promotion.setRoomTypes(roomtypes);
        promotionService.save(promotion);
        return "redirect:/manager/view-promotions";
    }
    
    @RequestMapping(value = {"/view-promotions"}, method = RequestMethod.GET)
    public String viewPromotions(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        model.addAttribute("promotions", promotionService.getPromotions());
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "manager/view-promotions";

    }
    
    @RequestMapping("/promotion-delete/{promotionId}")
    public String deletePromotion(Model model,
            @PathVariable("promotionId") int promotionId) {
        if (promotionService.deletePromotion(promotionId)) {
            return "redirect:/manager/view-promotions?type=error&message=Delete Room Id: " + promotionId + " Fail!!!";
        } else {
            return "redirect:/manager/view-promotions?type=success&message=Delete Room Id: " + promotionId + " success!!!";
        }
    }
    
// End of Promotion controllers
    
// Service controllers
    @RequestMapping("/service-add")
    public String addService(Model model) {
        model.addAttribute("service", new ServiceEntity());
        model.addAttribute("status", ServiceStatus.values());
        model.addAttribute("action", "add");
        return "manager/service-add";
    }
    
    @RequestMapping("/service-edit/{serviceId}")
    public String editService(Model model,
            @PathVariable("serviceId") int serviceId) {
        ServiceEntity service = serviceService.findById(serviceId);
        model.addAttribute("service", service);
        model.addAttribute("status", ServiceStatus.values());
        model.addAttribute("action", "edit");
        
        return "manager/service-add";
    }
    
    @RequestMapping(value = "/result-service", method = RequestMethod.POST)
    public String resultService(Model model,
            @Valid  @ModelAttribute("service") ServiceEntity service,
            HttpServletRequest request) {
        if (service.getImagesUpload() != null && service.getImagesUpload().length > 0) {
                service.setImages(imageService.uploadImageToService(service.getImagesUpload(), request, service));
            }
        
        serviceService.save(service);
        return "redirect:/manager/view-services";
    }
    
    @RequestMapping(value = {"/view-services"}, method = RequestMethod.GET)
    public String viewServices(Model model,
            @RequestParam(name = "type", required = false) String type,
            @RequestParam(name = "message", required = false) String message) {
        model.addAttribute("services", serviceService.getServices());
        model.addAttribute("type", type);
        model.addAttribute("message", message);
        return "manager/view-services";

    }
    
    @RequestMapping("/service-delete/{serviceId}")
    public String deleteService(Model model,
            @PathVariable("serviceId") int serviceId) {
        if (serviceService.deleteService(serviceId)) {
            return "redirect:/manager/view-services?type=error&message=Delete Room Id: " + serviceId + " Fail!!!";
        } else {
            return "redirect:/manager/view-services?type=success&message=Delete Room Id: " + serviceId + " success!!!";
        }
    }
// End of Service controllers
}

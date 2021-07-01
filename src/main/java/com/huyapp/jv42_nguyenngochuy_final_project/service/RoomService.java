/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.huyapp.jv42_nguyenngochuy_final_project.service;

import com.huyapp.jv42_nguyenngochuy_final_project.entities.RoomEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.repository.RoomRepository;
import java.util.List;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author PC
 */
@Service
public class RoomService {
    @Autowired
    private RoomRepository roomRepository;

    // Find room by Id
    public RoomEntity findById(int id) {
        Optional<RoomEntity> optionalRoom
                = roomRepository.findById(id);
        if (optionalRoom.isPresent()) {
            return optionalRoom.get();
        } else {
            return new RoomEntity();
        }
    }
    
    // Get all Rooms
    public List<RoomEntity> getRooms() {
        return (List<RoomEntity>) roomRepository.findAll();
    }
    
    // Get all available rooms for booking
    public List<RoomEntity> getAvailableRooms() {
        return (List<RoomEntity>) roomRepository.findAvailableRooms();
    }
    
    // Delete room by Id
    public boolean deleteRoom(int id) {
        roomRepository.deleteById(id);
        return roomRepository.existsById(id);
    }
    
    // Save room
    public void save(RoomEntity room) {
        roomRepository.save(room);
    }
}

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.huyapp.jv42_nguyenngochuy_final_project.repository;

import com.huyapp.jv42_nguyenngochuy_final_project.entities.RoomEntity;
import com.huyapp.jv42_nguyenngochuy_final_project.entities.RoomTypeEntity;
import java.util.List;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author PC
 */
@Repository
public interface RoomRepository extends
        CrudRepository<RoomEntity, Integer> {
    @Query("Select r From RoomEntity r where r.status = 'AVAILABLE'")
    List<RoomEntity> findAvailableRooms();
    
//    @Query(value = "Select * from room r where status= 'AVAILABLE'", nativeQuery = true)
//    List<RoomEntity> findAvailableRooms();
}

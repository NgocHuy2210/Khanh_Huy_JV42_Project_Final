/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.huyapp.jv42_nguyenngochuy_final_project.repository;

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
public interface RoomTypeRepository extends
        CrudRepository<RoomTypeEntity, Integer> {
    @Query("Select rt From RoomTypeEntity rt join fetch rt.rooms room where room.id = ?1")
    RoomTypeEntity findRoomTypeByRoomId(int roomId);
    
    @Query("Select rt From RoomTypeEntity rt join fetch rt.promotions promotion where promotion.id = ?1")
    List<RoomTypeEntity> findRoomTypeOfPromotion(int promotionId);
    
//    @Query(value = "Select rt.* from room_type rt"
//            + " join roomtype_promotion rtpr on rt.id = rtpr.roomtype_id"
//            + " join promotion pr on rtpr.promotion_id = pr.id"
//            + " where pr.id = ?1", nativeQuery = true)
//    List<RoomTypeEntity> findRoomTypeOfPromotion(int promotionId);
    
}

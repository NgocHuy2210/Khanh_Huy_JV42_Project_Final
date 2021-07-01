/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.huyapp.jv42_nguyenngochuy_final_project.entities;

import com.huyapp.jv42_nguyenngochuy_final_project.enums.BookingStatus;
import java.io.Serializable;
import java.time.LocalDate;
import java.util.List;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.Min;
import org.springframework.format.annotation.DateTimeFormat;

/**
 *
 * @author PC
 */
@Entity
@Table(name = "booking")
public class BookingEntity extends Personal implements Serializable {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    
    @Column(name = "booking_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate bookingDate;
    
    @Column(name = "checkin_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkinDate;
    
    @Column(name = "checkout_date")
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate checkoutDate;
    
    @Enumerated(EnumType.STRING)
    private BookingStatus status = BookingStatus.AVAILABLE;
    
    @Column(nullable = false)
    @Min(value = 0)
    private double totalPrice;
    
    @OneToMany(mappedBy = "booking", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<PaymentEntity> payments;
    
    @OneToMany(mappedBy = "booking", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<BookingDetailEntity> bookingDetails;
    
    @OneToMany(mappedBy = "booking", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
    private List<GuestEntity> guests;

    public BookingEntity() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public LocalDate getBookingDate() {
        return bookingDate;
    }

    public void setBookingDate(LocalDate bookingDate) {
        this.bookingDate = bookingDate;
    }

    public LocalDate getCheckinDate() {
        return checkinDate;
    }

    public void setCheckinDate(LocalDate checkinDate) {
        this.checkinDate = checkinDate;
    }

    public LocalDate getCheckoutDate() {
        return checkoutDate;
    }

    public void setCheckoutDate(LocalDate checkoutDate) {
        this.checkoutDate = checkoutDate;
    }

    public BookingStatus getStatus() {
        return status;
    }

    public void setStatus(BookingStatus status) {
        this.status = status;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<PaymentEntity> getPayments() {
        return payments;
    }

    public void setPayments(List<PaymentEntity> payments) {
        this.payments = payments;
    }

    public List<BookingDetailEntity> getBookingDetails() {
        return bookingDetails;
    }

    public void setBookingDetails(List<BookingDetailEntity> bookingDetails) {
        this.bookingDetails = bookingDetails;
    }

    public List<GuestEntity> getGuests() {
        return guests;
    }

    public void setGuests(List<GuestEntity> guests) {
        this.guests = guests;
    }
    
    
}

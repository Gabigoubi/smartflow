package com.smartflow.entity;
import jakarta.persistence.*;
import java.time.LocalDateTime;

@Entity
@Table(name = "appointments")
public class Appointment {
@Id 
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;
@Column(name = "schedule_date", nullable = false)
private LocalDateTime scheduleDate;
@Column(name = "status", nullable = false)
private String status;
@ManyToOne
@JoinColumn(name = "customer_id", nullable = false)
private Customer customer;
}
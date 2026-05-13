package com.smartflow.entity;
import jakarta.persistence.*;
import java.time.LocalDate;

@Entity
@Table(name = "customers")
public class Customer {
@Id 
@GeneratedValue(strategy = GenerationType.IDENTITY)
private Long id;
@Column(name = "car_model", nullable = false)
private String carModel;
@Column(name = "name", nullable = false)
private String name;
@Column(name = "next_revision_date", nullable = false)
private LocalDate nextRevisionDate;
}


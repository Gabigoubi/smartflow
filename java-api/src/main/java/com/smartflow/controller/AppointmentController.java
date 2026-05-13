package com.smartflow.controller;

import com.smartflow.entity.Appointment;
import com.smartflow.repository.AppointmentRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/agendamentos") 
public class AppointmentController {

    @Autowired
    private AppointmentRepository repository;

    @PostMapping
    public Appointment createAppointment(@RequestBody Appointment appointment) {
        return repository.save(appointment);
    }
}

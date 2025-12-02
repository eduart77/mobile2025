package com.example.roomscanpro.ui

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.roomscanpro.databinding.ActivityMainBinding

class MainActivity : AppCompatActivity() {
    private lateinit var binding: ActivityMainBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.btnCreate.setOnClickListener {
            startActivity(Intent(this, CreateRoomActivity::class.java))
        }
        binding.btnRead.setOnClickListener {
            startActivity(Intent(this, ReadRoomsActivity::class.java))
        }
        binding.btnUpdate.setOnClickListener {
            startActivity(Intent(this, UpdateRoomActivity::class.java))
        }
        binding.btnDelete.setOnClickListener {
            startActivity(Intent(this, DeleteRoomActivity::class.java))
        }
    }
}


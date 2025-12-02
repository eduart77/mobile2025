package com.example.roomscanpro.ui

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.roomscanpro.data.InMemoryRoomRepository
import com.example.roomscanpro.databinding.ActivityCreateRoomBinding

class CreateRoomActivity : AppCompatActivity() {
    private lateinit var binding: ActivityCreateRoomBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityCreateRoomBinding.inflate(layoutInflater)
        setContentView(binding.root)

        binding.btnSave.setOnClickListener {
            val name = binding.etRoomName.text.toString().trim()
            val type = binding.etRoomType.text.toString().trim()
            val length = binding.etLength.text.toString().toDoubleOrNull() ?: 0.0
            val width = binding.etWidth.text.toString().toDoubleOrNull() ?: 0.0
            val height = binding.etHeight.text.toString().toDoubleOrNull() ?: 0.0

            if (name.isEmpty() || type.isEmpty()) {
                Toast.makeText(this, "Please fill all fields", Toast.LENGTH_SHORT).show()
                return@setOnClickListener
            }

            InMemoryRoomRepository.createRoom(name, type, length, width, height)
            Toast.makeText(this, "Room created", Toast.LENGTH_SHORT).show()
            finish()
        }
    }
}


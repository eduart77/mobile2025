package com.example.roomscanpro.ui

import android.content.Intent
import android.os.Bundle
import android.view.View
import androidx.appcompat.app.AppCompatActivity
import com.example.roomscanpro.data.InMemoryRoomRepository
import com.example.roomscanpro.databinding.ActivityReadRoomsBinding

class ReadRoomsActivity : AppCompatActivity() {
    private lateinit var binding: ActivityReadRoomsBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityReadRoomsBinding.inflate(layoutInflater)
        setContentView(binding.root)

        refreshList()
    }

    override fun onResume() {
        super.onResume()
        refreshList()
    }

    private fun refreshList() {
        val rooms = InMemoryRoomRepository.listRooms()
        if (rooms.isEmpty()) {
            binding.tvEmpty.visibility = View.VISIBLE
            binding.listRooms.adapter = null
        } else {
            binding.tvEmpty.visibility = View.GONE
            val adapter = RoomAdapter(this, rooms)
            binding.listRooms.adapter = adapter
        }
    }
}
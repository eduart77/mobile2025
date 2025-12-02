package com.example.roomscanpro.ui

import android.os.Bundle
import android.widget.ArrayAdapter
import android.widget.Toast
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import com.example.roomscanpro.data.InMemoryRoomRepository
import com.example.roomscanpro.data.Room
import com.example.roomscanpro.databinding.ActivityDeleteRoomBinding

class DeleteRoomActivity : AppCompatActivity() {
    private lateinit var binding: ActivityDeleteRoomBinding
    private var selectedRoom: Room? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityDeleteRoomBinding.inflate(layoutInflater)
        setContentView(binding.root)

        refreshRooms()

        binding.btnDelete.setOnClickListener {
            val room = selectedRoom ?: return@setOnClickListener

            AlertDialog.Builder(this)
                .setTitle("Delete Room")
                .setMessage("Are you sure you want to delete this room?")
                .setPositiveButton("Yes") { _, _ ->
                    val deleted = InMemoryRoomRepository.deleteRoom(room.roomId)
                    Toast.makeText(this, if (deleted) "Room deleted" else "Delete failed", Toast.LENGTH_SHORT).show()
                    if (deleted) {
                        // Navigate to the Read (list) screen after delete
                        startActivity(android.content.Intent(this, ReadRoomsActivity::class.java).apply {
                            addFlags(android.content.Intent.FLAG_ACTIVITY_CLEAR_TOP)
                        })
                        finish()
                    }
                }
                .setNegativeButton("No", null)
                .show()
        }
    }

    private fun refreshRooms() {
        val rooms = InMemoryRoomRepository.listRooms()
        if (rooms.isEmpty()) {
            binding.tvEmpty.visibility = android.view.View.VISIBLE
            binding.contentLayout.visibility = android.view.View.GONE
            selectedRoom = null
            return
        } else {
            binding.tvEmpty.visibility = android.view.View.GONE
            binding.contentLayout.visibility = android.view.View.VISIBLE
        }

        val labels = rooms.map { it.roomName }
        val adapter = ArrayAdapter(this, android.R.layout.simple_spinner_dropdown_item, labels)
        binding.spinnerRooms.adapter = adapter
        if (rooms.isNotEmpty()) {
            setSelectedRoom(rooms.first())
        }
        binding.spinnerRooms.setOnItemSelectedListener(object : android.widget.AdapterView.OnItemSelectedListener {
            override fun onItemSelected(parent: android.widget.AdapterView<*>?, view: android.view.View?, position: Int, id: Long) {
                selectedRoom = rooms.getOrNull(position)
            }
            override fun onNothingSelected(parent: android.widget.AdapterView<*>?) { }
        })
    }

    private fun setSelectedRoom(room: Room) {
        selectedRoom = room
    }
}

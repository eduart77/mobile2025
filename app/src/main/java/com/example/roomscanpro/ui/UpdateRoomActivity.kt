package com.example.roomscanpro.ui

import android.os.Bundle
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.roomscanpro.data.InMemoryRoomRepository
import com.example.roomscanpro.data.Room
import com.example.roomscanpro.databinding.ActivityUpdateRoomBinding

class UpdateRoomActivity : AppCompatActivity() {
    private lateinit var binding: ActivityUpdateRoomBinding
    private var room: Room? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityUpdateRoomBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val roomId = intent.getStringExtra("ROOM_ID")
        if (roomId == null) {
            Toast.makeText(this, "Room not found", Toast.LENGTH_SHORT).show()
            finish()
            return
        }

        room = InMemoryRoomRepository.findRoom(roomId)
        if (room == null) {
            Toast.makeText(this, "Room not found", Toast.LENGTH_SHORT).show()
            finish()
            return
        }

        populateRoomData()

        binding.btnUpdate.setOnClickListener {
            updateRoom()
        }
    }

    private fun populateRoomData() {
        room?.let {
            binding.etRoomName.setText(it.roomName)
            binding.etRoomType.setText(it.roomType)
            binding.etLength.setText(it.lengthMeters.toString())
            binding.etWidth.setText(it.widthMeters.toString())
            binding.etHeight.setText(it.heightMeters.toString())
        }
    }

    private fun updateRoom() {
        val currentRoom = room ?: return

        val updated = InMemoryRoomRepository.updateRoom(
            currentRoom.roomId,
            binding.etRoomName.text.toString().trim(),
            binding.etRoomType.text.toString().trim(),
            binding.etLength.text.toString().toDoubleOrNull() ?: currentRoom.lengthMeters,
            binding.etWidth.text.toString().toDoubleOrNull() ?: currentRoom.widthMeters,
            binding.etHeight.text.toString().toDoubleOrNull() ?: currentRoom.heightMeters,
        )

        if (updated) {
            Toast.makeText(this, "Room updated", Toast.LENGTH_SHORT).show()
            startActivity(android.content.Intent(this, ReadRoomsActivity::class.java).apply {
                addFlags(android.content.Intent.FLAG_ACTIVITY_CLEAR_TOP)
            })
            finish()
        } else {
            Toast.makeText(this, "Update failed", Toast.LENGTH_SHORT).show()
        }
    }
}

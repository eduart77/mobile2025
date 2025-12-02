package com.example.roomscanpro.data

import java.util.UUID

object InMemoryRoomRepository {
    private val rooms: MutableList<Room> = mutableListOf(
        Room(UUID.randomUUID().toString(), "Living Room", "Living Room", 5.0, 4.0, 2.7),
        Room(UUID.randomUUID().toString(), "Bedroom", "Bedroom", 4.0, 3.2, 2.7)
    )

    fun listRooms(): List<Room> = rooms.toList()

    fun createRoom(
        name: String,
        type: String,
        length: Double,
        width: Double,
        height: Double
    ): Room {
        val newRoom = Room(UUID.randomUUID().toString(), name, type, length, width, height)
        rooms.add(newRoom)
        return newRoom
    }

    fun findRoom(roomId: String): Room? = rooms.find { it.roomId == roomId }

    fun updateRoom(
        roomId: String,
        name: String,
        type: String,
        length: Double,
        width: Double,
        height: Double
    ): Boolean {
        val room = findRoom(roomId) ?: return false
        room.roomName = name
        room.roomType = type
        room.lengthMeters = length
        room.widthMeters = width
        room.heightMeters = height
        return true
    }

    fun deleteRoom(roomId: String): Boolean {
        return rooms.removeIf { it.roomId == roomId }
    }
}


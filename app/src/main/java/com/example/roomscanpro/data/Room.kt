package com.example.roomscanpro.data

data class Room(
    val roomId: String,
    var roomName: String,
    var roomType: String,
    var lengthMeters: Double,
    var widthMeters: Double,
    var heightMeters: Double
)


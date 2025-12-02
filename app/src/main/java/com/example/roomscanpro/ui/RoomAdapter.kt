package com.example.roomscanpro.ui

import android.content.Context
import android.content.Intent
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ArrayAdapter
import android.widget.ImageButton
import android.widget.TextView
import com.example.roomscanpro.R
import com.example.roomscanpro.data.Room

class RoomAdapter(context: Context, rooms: List<Room>) : ArrayAdapter<Room>(context, 0, rooms) {

    override fun getView(position: Int, convertView: View?, parent: ViewGroup): View {
        val room = getItem(position)
        val view = convertView ?: LayoutInflater.from(context).inflate(R.layout.item_room, parent, false)

        val tvRoomName = view.findViewById<TextView>(R.id.tvRoomName)
        val btnEditRoom = view.findViewById<ImageButton>(R.id.btnEditRoom)

        tvRoomName.text = room?.roomName

        btnEditRoom.setOnClickListener {
            val intent = Intent(context, UpdateRoomActivity::class.java)
            intent.putExtra("ROOM_ID", room?.roomId)
            context.startActivity(intent)
        }

        return view
    }
}
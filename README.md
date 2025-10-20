Description:
RoomScan Pro is a mobile application that helps homeowners and renters visualize and manage their living spaces. The app uses your iPhone's advanced LiDAR sensor to create detailed 3D scans of rooms, or allows you to upload existing apartment floor plans. Once scanned, you can virtually arrange furniture, plan renovations, and share room layouts with family members or contractors. The app stores all your room data securely on your device and syncs it to the cloud, so you can access your layouts from any device. Whether you're moving to a new place, redecorating, or just want to see how new furniture would look, RoomScan Pro makes space planning simple and intuitive.

Domain details:
Entity 1: Room

  - roomId (String): Unique identifier for each room, automatically generated when a room is created
  - roomName (String): User-defined name for the room (e.g., "Living Room", "Master Bedroom")
  - roomType (String): Category of the room (bedroom, kitchen, bathroom, living room, office, etc.)
  - scanData (Binary): 3D point cloud data captured by LiDAR sensor or uploaded floor plan image
  - dimensions (Object): Room measurements including length, width, height in meters
  - createdDate (DateTime): Timestamp when the room was first scanned or created
  - lastModified (DateTime): Timestamp of the most recent modification to the room data
    
Entity 2: Furniture

  - furnitureId (String): Unique identifier for each furniture item placed in rooms
  - furnitureName (String): Name of the furniture item (e.g., "Sofa", "Dining Table", "Bookshelf")
  - furnitureType (String): Category of furniture (seating, storage, table, bed, decorative, etc.)
  - position (Object): 3D coordinates (x, y, z) and rotation angles where furniture is placed
  - dimensions (Object): Length, width, height of the furniture item in meters
  - roomId (String): Foreign key linking furniture to the room it belongs to
  - isCustom (Boolean): Flag indicating if furniture was created by user or selected from catalog

Room Entity Operations:
  
    CREATE Room:
  
      - User initiates room scan using LiDAR sensor or uploads floor plan image
      - App processes scan data and extracts room dimensions automatically
      - User provides room name and selects room type from predefined categories
      - System generates unique roomId and timestamps
      - Room data is validated for completeness before saving
      
    READ Room:
  
      - Retrieve single room by roomId for detailed view and editing
      - List all rooms belonging to user with basic information (name, type, dimensions)
      - Search rooms by name or filter by room type
      - Load room with all associated furniture items for 3D visualization
      - Access room scan data for rendering 3D model
      
    UPDATE Room:
  
      - Modify room name, type, or dimensions through user interface
      - Re-scan room to update scanData while preserving existing furniture placements
      - Update room metadata (lastModified timestamp)
      - Validate changes before applying to ensure data integrity
      - Trigger furniture position recalculation if room dimensions change significantly
      
    DELETE Room:
  
      - Remove room and all associated furniture items
      - Confirm deletion with user to prevent accidental data loss
      - Clean up related scan data and 3D models
      - Update user's room count and available storage space
      - Log deletion for potential recovery within grace period
    
Furniture Entity Operations
  
    CREATE Furniture:
  
      - User selects furniture from catalog or creates custom item
      - Position furniture in 3D space using touch gestures or precise coordinates
      - Set furniture dimensions and orientation within room constraints
      - Validate furniture placement doesn't overlap with existing items
      - Generate unique furnitureId and associate with target room
    
    READ Furniture:
  
      - Display furniture items within specific room context
      - Retrieve furniture details for editing (position, dimensions, properties)
      - Search furniture by name, type, or room location
      - Load furniture catalog with available items and their specifications
      - Generate furniture list for room export or sharing
    
    UPDATE Furniture:
  
      - Modify furniture position, rotation, or dimensions through drag-and-drop interface
      - Change furniture properties (name, type, material, color)
      - Update furniture placement when room dimensions change
      - Validate new position doesn't create overlaps or exceed room boundaries
      - Save changes with timestamp and sync across devices
    
    DELETE Furniture:
  
      - Remove furniture item from room layout
      - Confirm deletion to prevent accidental removal
      - Update room's furniture count and available space calculations
      - Clean up furniture-specific data and 3D model references
      - Log deletion for potential undo functionality

Local Database Operations:

    - CREATE Operations:
    
        - Create Room: Store room data locally for immediate access and offline functionality
        - Create Furniture: Save furniture items locally to enable offline room editing
        - Create User Preferences: Store app settings, theme preferences, and user configurations locally
        
    - READ Operations:
    
        - Read Room List: Load all user rooms from local database for quick access
        - Read Furniture Catalog: Cache furniture items locally for offline browsing
        - Read User Settings: Retrieve app preferences and configurations from local storage
        
    - UPDATE Operations:
    
        - Update Room Properties: Modify room names, types, and basic information locally
        - Update Furniture Positions: Save furniture placement changes locally for immediate feedback
        - Update App Settings: Store user preference changes locally before syncing
Server Database Operations:

    - CREATE Operations:
    
        - Create Room: Sync new rooms to cloud for cross-device access and backup
        - Create Furniture: Upload furniture data to server for sharing and collaboration
        - Create User Account: Register new users and store profile information on server
        
    - READ Operations:
    
        - Read Shared Rooms: Access rooms shared by other users or family members
        - Read Furniture Catalog: Download latest furniture items and updates from server
        - Read User Profile: Retrieve user account information and subscription details
        
    - UPDATE Operations:
    
        - Update Room Sync: Synchronize room modifications across all user devices
        - Update Furniture Sync: Push furniture changes to cloud for real-time collaboration
        - Update User Profile: Save account changes, subscription updates, and preferences to server

App preview:

<img width="370" height="707" alt="image" src="https://github.com/user-attachments/assets/234fb8db-e100-4099-bbce-136d05535026" />
<img width="372" height="706" alt="image" src="https://github.com/user-attachments/assets/e4b8a076-f00d-47b4-a0b5-a381c7d2949d" />
<img width="373" height="706" alt="image" src="https://github.com/user-attachments/assets/ddb29ee5-637a-42ae-b8eb-de8adcce7740" />
<img width="370" height="704" alt="image" src="https://github.com/user-attachments/assets/73eed5f8-f53b-455f-a360-f4e57b4b4937" />
<img width="370" height="704" alt="image" src="https://github.com/user-attachments/assets/4929f3f3-5d7e-4906-9b2b-6f26112f14e4" />
<img width="371" height="707" alt="image" src="https://github.com/user-attachments/assets/2fe869cf-d510-4d03-bc71-0b3c9b82e661" />



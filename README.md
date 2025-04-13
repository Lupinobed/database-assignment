# Train Booking Database

## Database Tables

### `booking_status`
| Column        | Type       | Description                     |
|---------------|------------|---------------------------------|
| status_id     | INT (PK)   | Unique status identifier        |
| status_name   | VARCHAR    | e.g., "Confirmed", "Cancelled"  |

### `train_station`
| Column        | Type       | Description                     |
|---------------|------------|---------------------------------|
| station_id    | INT (PK)   | Unique station identifier       |
| station_name  | VARCHAR    | Name of the station             |
| location      | VARCHAR    | City/region                     |

### `train_journey`
| Column          | Type       | Description                     |
|-----------------|------------|---------------------------------|
| journey_id      | INT (PK)   | Unique journey identifier       |
| departure_station| INT (FK)   | References train_station        |
| arrival_station | INT (FK)   | References train_station        |
| departure_time  | DATETIME   | Scheduled departure             |

[Continue with other tables...]

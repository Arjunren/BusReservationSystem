# Bus Reservation System

## Overview
A small production-structured Java API for buses, routes, scheduled trips, seat reservations, cancellation, and revenue reporting.

## Features
- Revocable bearer-token login/logout with Admin and Passenger roles
- Bus, route, and trip administration
- Transactional seat booking with capacity and duplicate-seat protection
- Passenger-owned booking views and cancellation
- Dashboard summary and server-controlled fares

## Technology Stack
Java 21, Javalin 7.2.3, JDBC, H2 2.5.250, JUnit 6.1.3, Maven 3.9.16, Docker.

## Requirements
Java 21+ and Maven 3.9.16+.

## Installation and Running
```bash
mvn clean package
java -jar target/bus-reservation-system-1.0.0.jar
```
The schema in `src/main/resources/db/migration.sql` is applied automatically and seed data is idempotent.

## Environment Variables
Use `.env.example` to configure `DB_URL`, database credentials, `PORT`, and `CORS_ORIGIN`. Never commit production secrets.

## Running Tests
Run `mvn verify`. Four integration-style service tests cover fare control, seat uniqueness, capacity, and ownership cancellation.

## Default Development Accounts
`admin` and `passenger`, password `ChangeMe123!` (development only).

## API Endpoints
`POST /api/auth/login`, `POST /api/auth/logout`, `GET/POST /api/buses`, `POST /api/routes`, `GET/POST /api/trips`, `GET/POST /api/bookings`, `PATCH /api/bookings/{id}/cancel`, `GET /api/dashboard`.

## Folder Structure
`Main` defines HTTP routes, `AuthService` manages revocable sessions, `BookingService` owns transactions, `Database` applies migrations, resources contain SQL, and tests validate business rules.

## Security Notes
Passwords use salted PBKDF2-HMAC-SHA256 with 210,000 iterations. Random tokens are stored only as SHA-256 hashes and expire after two hours. Roles and booking ownership are checked server-side; JDBC statements are parameterized; booking decisions are transactional and backed by unique constraints. Deploy behind HTTPS and replace development database credentials.

## Known Limitations
H2 is intended for local demonstration. Production should use PostgreSQL, add refresh/session administration, payment processing, and distributed transaction retry handling.

## License
MIT

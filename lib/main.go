package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"strconv"
	"github.com/rs/cors"
)

// Car представляет объект машины
type Car struct {
	ID          int     `json:"id"`
	Brand       string  `json:"brand"`
	Model       string  `json:"model"`
	Price       float64 `json:"price"`
	Year        int     `json:"year"`
	Description string  `json:"description"`
	IsAvailable bool    `json:"isAvailable"`
}

// Пример списка машин
var cars = []Car{
	{ID: 1, Brand: "Tesla", Model: "Model S", Price: 79999.99, Year: 2023, Description: "Электромобиль премиум-класса", IsAvailable: true},
	{ID: 2, Brand: "Toyota", Model: "Camry", Price: 24999.99, Year: 2021, Description: "Надежный седан среднего класса", IsAvailable: true},
	{ID: 3, Brand: "BMW", Model: "X5", Price: 59999.99, Year: 2022, Description: "Роскошный внедорожник", IsAvailable: false},
}

var lastID = 3

// обработчик для получения всех машин
func getCarsHandler(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(cars)
}

// обработчик для создания новой машины
func createCarHandler(w http.ResponseWriter, r *http.Request) {
	if r.Method != http.MethodPost {
		http.Error(w, "Invalid request method", http.StatusMethodNotAllowed)
		return
	}

	var newCar Car
	err := json.NewDecoder(r.Body).Decode(&newCar)
	if err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	lastID++
	newCar.ID = lastID
	cars = append(cars, newCar)

	w.Header().Set("Content-Type", "application/json")
	w.WriteHeader(http.StatusCreated)
	json.NewEncoder(w).Encode(newCar)
}

// обработчик для получения машины по ID
func getCarByIDHandler(w http.ResponseWriter, r *http.Request) {
	idStr := r.URL.Path[len("/cars/"):]

	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Car ID", http.StatusBadRequest)
		return
	}

	for _, car := range cars {
		if car.ID == id {
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(car)
			return
		}
	}

	http.Error(w, "Car not found", http.StatusNotFound)
}

// обработчик для обновления машины по ID
func updateCarHandler(w http.ResponseWriter, r *http.Request) {
	idStr := r.URL.Path[len("/cars/update/"):]

	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Car ID", http.StatusBadRequest)
		return
	}

	var updatedCar Car
	err = json.NewDecoder(r.Body).Decode(&updatedCar)
	if err != nil {
		http.Error(w, "Invalid request body", http.StatusBadRequest)
		return
	}

	for i, car := range cars {
		if car.ID == id {
			cars[i] = updatedCar
			cars[i].ID = id
			w.Header().Set("Content-Type", "application/json")
			json.NewEncoder(w).Encode(cars[i])
			return
		}
	}

	http.Error(w, "Car not found", http.StatusNotFound)
}

// обработчик для удаления машины по ID
func deleteCarHandler(w http.ResponseWriter, r *http.Request) {
	idStr := r.URL.Path[len("/cars/delete/"):]

	id, err := strconv.Atoi(idStr)
	if err != nil {
		http.Error(w, "Invalid Car ID", http.StatusBadRequest)
		return
	}

	for i, car := range cars {
		if car.ID == id {
			cars = append(cars[:i], cars[i+1:]...)
			w.WriteHeader(http.StatusNoContent)
			return
		}
	}

	http.Error(w, "Car not found", http.StatusNotFound)
}

func main() {
	// Инициализация CORS
	corsHandler := cors.New(cors.Options{
		AllowedOrigins: []string{"http://localhost:55433"}, // Разрешаем фронтенд из этого источника
		AllowedMethods: []string{"GET", "POST", "PUT", "DELETE"},
		AllowedHeaders: []string{"Content-Type"},
	})

	http.HandleFunc("/cars", func(w http.ResponseWriter, r *http.Request) {
		if r.Method == http.MethodGet {
			getCarsHandler(w, r)
		} else if r.Method == http.MethodPost {
			createCarHandler(w, r)
		} else {
			http.Error(w, "Method not allowed", http.StatusMethodNotAllowed)
		}
	})
	http.HandleFunc("/cars/", getCarByIDHandler)           // Получение машины по ID
	http.HandleFunc("/cars/update/", updateCarHandler)     // Обновление машины
	http.HandleFunc("/cars/delete/", deleteCarHandler)     // Удаление машины

	// Запуск сервера с CORS
	fmt.Println("Server is running on port 8080")
	http.ListenAndServe(":8080", corsHandler.Handler(http.DefaultServeMux))
}

package main

import (
	"github.com/Khip01/Restaurant_Khip01/controllers/menu_controller"
	"github.com/Khip01/Restaurant_Khip01/models"
	"github.com/gin-gonic/gin"
)

func main() {
	// Declare Route
	route := gin.Default()

	// connect Database
	models.ConnectToDatabase()

	// Route
	route.GET("/api/Menus", menu_controller.Menus)
	route.GET("/api/Menu/:id", menu_controller.GetMenu)
	route.POST("/api/Menu", menu_controller.CreateMenu)
	route.PUT("/api/Menu/:id", menu_controller.UpdateMenu)
	route.DELETE("/api/Menu", menu_controller.DeleteMenu)

	// Eksekusi
	route.Run(":8081")
}

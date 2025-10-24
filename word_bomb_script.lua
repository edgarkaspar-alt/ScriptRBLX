-- Script para autocompletar frases en Word Bomb

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
local ScreenGui = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextLabel")

-- Configuración del aviso
TextLabel.Size = UDim2.new(0, 200, 0, 50)
TextLabel.Position = UDim2.new(0, 10, 0, 10)
TextLabel.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
TextLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TextLabel.Text = "Script en ejecución"
TextLabel.TextSize = 24
TextLabel.TextScaled = true

ScreenGui.Parent = game:GetService("CoreGui")
TextLabel.Parent = ScreenGui

-- URL del servidor que proporciona las letras necesarias
local serverUrl = "https://ejemplo.com/api/letras"

-- Función para obtener las letras necesarias del servidor
local function getRequiredLetters()
    local response = HttpService:GetAsync(serverUrl)
    local data = HttpService:JSONDecode(response)
    return data.letras
end

-- Función para completar la frase automáticamente
local function completePhrase(requiredLetters)
    local phrase = "" -- Aquí deberías obtener la frase actual del juego
    for _, letter in ipairs(requiredLetters) do
        phrase = phrase .. letter
    end
    -- Simula la entrada de texto
    for i = 1, #phrase do
        UserInputService:InputBegan({
            KeyCode = Enum.KeyCode[phrase:sub(i, i):upper()],
            UserInputType = Enum.UserInputType.Keyboard
        }, true)
    end
end

-- Función principal que se ejecuta al inicio del script
local function main()
    while true do
        local requiredLetters = getRequiredLetters()
        completePhrase(requiredLetters)
        wait(1) -- Ajusta el tiempo de espera según sea necesario
    end
end

-- Inicia el script
main()
-- Script para autocompletar frases en Word Bomb

local HttpService = game:GetService("HttpService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer
local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()

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
--=== RMS 1.6.1V ===
--==================
--data: 25/01/2025

--Base do sistema
local monitor = peripheral.wrap("monitor_0")
local monitorProducao = peripheral.wrap("monitor_1")
local bateria = peripheral.wrap("basicEnergyCube_0")

monitor.clear()
monitor.setCursorPos(1,1)

local energiaAtual = bateria.getEnergy()
local energiaTotal = bateria.getMaxEnergy()
local porcentagem = (energiaAtual / energiaTotal) * 100

--Imprime a barra e a porcentagem
  function ImprimirBarra(porcentagem)
    local barra = "|"
    local carregado = porcentagem
  
    for i = 1, 10 do
      if porcentagem - 10 >= 0 then
        barra = barra .. "#"
        porcentagem = porcentagem - 10
      else
        barra = barra .. "="
      end
    end
  
    barra = barra .. "| " .. carregado .. "%"
    monitor.write(barra)
  end

  --Funcao para autenticar a inicializacao
  function Autenticar()
    local estado = 0
  
    local usuario
    local senha
  
    while estado == 0 do
      print("Usuario:")
      usuario = read()
      print("Senha:")
      senha = read()
  
      if usuario == "admin" then
        if senha == "rms1" then
          print("Usuario Autenticado\n")
          estado = 1
          PrintHeader()
        end
      end
  
      if estado ~= 1 then
        print("Usuario ou Senha incorretos\n")
      end
    end
  
  
    return estado
  end
  
  --Imprime o cabecalho do sistema
  function PrintHeader()
    monitor.clear()
    monitor.setCursorPos(1,1)
    monitor.write("=== RMS 1.6.1V ===")
    monitor.setCursorPos(1,2)
    monitor.write("==================")
  end
  
  --Base do sistema
  PrintHeader()
  local estado = Autenticar()
  sleep(1)
  term.clear()
  
  while estado ~= 0 do
    porcentagem = 0

    if (bateria.getEnergy() ~= nil) and (bateria.getEnergy() ~= nil)then
      energiaAtual = bateria.getEnergy()
      energiaTotal = bateria.getMaxEnergy()
      porcentagem = (energiaAtual / energiaTotal) * 100
    end

    PrintHeader()
    monitor.setCursorPos(1,3)
    monitor.write("Energia:")
    monitor.setCursorPos(1,4)
    ImprimirBarra(porcentagem)
    monitor.setCursorPos(1,5)
    monitor.write("Agua:")
    monitor.setCursorPos(1,6)
    ImprimirBarra(porcentagem + 10)
    monitor.setCursorPos(1,7)
    monitor.write("Combustivel:")
    monitor.setCursorPos(1,8)
    ImprimirBarra(porcentagem - 3)
    sleep(2)
  end
  
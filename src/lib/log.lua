local log = {}
log.counter = 0
log.log = os.getenv("LOVE_LOG_GAME") or 0

---@param text string
function log.printlog(text)
  if log.log == 0 then return end
  local msg = string.format("[%d] %s", log.counter, text)
  log.counter = log.counter + 1
  print(msg)
end

return log

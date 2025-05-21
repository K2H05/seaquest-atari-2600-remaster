
---@class 
---@field 
local log = {}

---@enum log.Level
log.Level = {
	TRACE = { 1, "\x1b[34;1m", "Trace" },
	DEBUG = { 2, "\x1b[36;1m", "Debug" },
	INFO = { 3, "\x1b[32;1m", "Info" },
	WARN = { 4, "\x1b[33;1m", "Warning" },
	ERROR = { 5, "\x1b[31;1m", "Error" },
	FATAL = { 6, "\x1b[35;1m", "Fatal" },
}

log.level = log.Level.DEBUG
---@param 
---@param 
---@param 
function log._print(level, format, ...)
	if level[1] < log.level[1] then return end

	local info = debug.getinfo(3, "Sl")
	local lineinfo = info.short_src .. ":" .. info.currentline
	local date = os.date "%Y-%m-%d %H:%M:%S -- "
	local prefix = level[2] .. level[3] .. "\x1b[0m\t"
	local message = date .. prefix .. string.format(format, ...)

	print(message)

	if level == log.Level.FATAL then
		error(lineinfo .. ": " .. string.format(format, ...))
	end
end

---@param 
---@param 
function log.trace(format, ...) log._print(log.Level.TRACE, format, ...) end

---@param 
---@param 
function log.debug(format, ...) log._print(log.Level.DEBUG, format, ...) end

---@param 
---@param 
function log.info(format, ...) log._print(log.Level.INFO, format, ...) end

---@param 
---@param
function log.warn(format, ...) log._print(log.Level.WARN, format, ...) end

---@param 
---@param 
function log.error(format, ...) log._print(log.Level.ERROR, format, ...) end

---@param 
---@param 
function log.fatal(format, ...) log._print(log.Level.FATAL, format, ...) end

return log

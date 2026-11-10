---@meta
---@diagnostic disable: lowercase-global
---@diagnostic disable: missing-return
---@diagnostic disable: args-after-dots

---@class defold_api.lfs
---File system manipulation library.
lfs = {}

---Returns a table with the file attributes corresponding to 'filepath' (or
---'nil' followed by an error message and a system-dependent error code in case
---of error). If the second optional argument is given and is a string, then
---only the value of the named attribute is returned (this use is equivalent to
---'lfs.attributes(filepath)[request_name]', but the table is not created and
---only one attribute is retrieved from the OS). If a table is passed as the
---second argument, that table is filled with attributes and returned
---instead of a new table. The attributes are described as follows; attribute
---'mode' is a string, all the others are numbers, and the time related
---attributes use the same time reference of 'os.time':
--- 'dev'
---   on Unix systems, this represents the device that the inode resides on. On
---Windows systems, represents the drive number of the disk containing the file
--- 'ino'
---   on Unix systems, this represents the inode number. On Windows systems
---this has no meaning
--- 'mode'
---   string representing the associated protection mode (the values could be
---"file", "directory", "link", "socket", "named pipe", "char device",
---"block device" or "other")
--- 'nlink'
---   number of hard links to the file
--- 'uid'
---   user-id of owner (Unix only, always 0 on Windows)
--- 'gid'
---   group-id of owner (Unix only, always 0 on Windows)
--- 'rdev'
---   on Unix systems, represents the device type, for special file inodes. On
---Windows systems represents the same as 'dev'
--- 'access'
---   time of last access
--- 'modification'
---   time of last data modification
--- 'change'
---   time of last file status change
--- 'size'
---   file size, in bytes
--- 'permissions'
---   file permissions string
--- 'blocks'
---   block allocated for file; (Unix only)
--- 'blksize'
---   optimal file system I/O blocksize; (Unix only)
---
---This function uses 'stat' internally thus if the given 'filepath' is a
---symbolic link, it is followed (if it points to another link the chain is
---followed recursively) and the information is about the file it refers to.
---To obtain information about the link itself, see function
---'lfs.symlinkattributes'.
--- Examples:
---```
---  -- get a file's size
---  local filesize = lfs.attributes(path, "size")
---
---  -- fill an existing table with a file's attributes
---  att_table = lfs.attributes(path, att_table)
---```
---@param filepath string The file to read
---@param request_name?|result_table? string|table The name of an attribute to read by itself, or a table to fill with attributes
---@return table|nil A table with the file attributes corresponding to 'filepath' (or nil in case of error)
---@return string|nil An error message (in case of error)
---@return number|nil A system-dependent error code (in case of error)
function lfs.attributes(filepath, request_name|result_table) end

---Changes the current working directory to the given path. Returns 'true' in
---case of success or 'nil' plus an error string.
---@param path string
---@return boolean|nil 'true' if successful (or 'nil' in case of error)
---@return string|nil An error message (in case of error)
function lfs.chdir(path) end

---Returns the current working directory or 'nil' plus an error string.
---@return string|nil The current working directory (or 'nil' in case of error)
---@return string|nil An error message (in case of error)
function lfs.currentdir() end

---Lua iterator over the entries of a given directory. Each time the iterator is
---called with 'dir_obj' it returns a directory entry's name as a string, or
---'nil' if there are no more entries. You can also iterate by calling
---'dir_obj:next()', and explicitly close the directory before the iteration
---finished with 'dir_obj:close()'. Raises an error if 'path' is not a directory.
--- Examples:
---```
---  -- standard iterator
---  for file in lfs.dir(path) do
---    print(file)
---  end
---
---  -- stop the iterator early
---  local iter, dir_obj = lfs.dir(path)
---  for name in iter, dir_obj do
---    if name == "my_file.lua" then
---      dir_obj:close()
---      break
---    end
---  end
---```
---@param path string Directory to iterate over
---@return fun(state: userdata): string? iter The iterator function
---@return userdata dir_obj The opened directory
function lfs.dir(path) end

---Creates a link. The first argument is the object to link to and the second is
---the name of the link. If the optional third argument is 'true', the link will
---be a symbolic link (by default, a hard link is created).
---@param old userdata Object to link to
---@param new string The name of the link
---@param symlink? boolean If 'true', the link will be a symbolic link
---@return nil
function lfs.link(old, new, symlink) end

---Locks a file or a part of it. This function works on OPENED files; the file
---handle should be specified as the first argument. The string 'mode' could be
---either "r" (for a read/shared lock) or "w" (for a write/exclusive lock). The
---optional arguments 'start' and 'length' can be used to specify a starting
---point and its length; both should be numbers. Returns 'true' if the operation
---was successful; in case of error, it returns 'nil' plus an error string.
---@param filehandle userdata Handle for the file to lock
---@param mode string
---@param start? number
---@param length? number
---@return boolean|nil 'true' if successful (or 'nil' in case of error)
---@return string|nil An error message (in case of error)
function lfs.lock(filehandle, mode, start, length) end

---Creates a lockfile (called 'lockfile.lfs') in 'path' if it does not exist and
---returns the lock. If the lock already exists, checks if it's stale, using the
---second parameter (default for the second parameter is 'INT_MAX', which in
---practice means the lock will never be stale). To free the lock call
---'lock:free()'. In case of any errors it returns 'nil' and the error message.
---In particular, if the lock exists and is not stale it returns the "File
---exists" message.
---@param path string Directory to lock
---@param seconds_stale? number Lifetime for an existing lock, in seconds
---@return userdata|nil Handle for the lockfile (or 'nil' in case of error)
---@return string|nil An error message (in case of error)
function lfs.lock_dir(path, seconds_stale) end

---Creates a new directory. The argument is the name of the new directory.
---Returns 'true' in case of success, or 'nil', an error message, and a system-
---dependent error code in case of error.
---@param dir_name string The name for the new directory
---@return boolean|nil 'true' if successful (or 'nil' in case of error)
---@return string|nil An error message (in case of error)
---@return number|nil A system-dependent error code (in case of error)
function lfs.mkdir(dirname) end

---Removes an existing directory. The argument is the name of the directory.
---Returns 'true' in case of success, or 'nil', an error message and a system-
---dependent error code in case of error.
---@param dir_name string The name of the directory to remove
---@return boolean|nil 'true' if successful (or 'nil' in case of error)
---@return string|nil An error message (in case of error)
---@return number|nil A system-dependent error code (in case of error)
function lfs.rmdir(dirname) end

---Sets the writing mode for a file. The mode string can be either "binary" or
---"text". Returns 'true' followed the previous mode string for the file, or
---'nil' followed by an error string in case of errors. On non-Windows
---platforms, where the two modes are identical, setting the mode has no effect,
---and the mode is always returned as binary. 
---@param filepath string The file to change
---@param mode string Either "binary" or "text"
---@return boolean|nil 'true' if successful (or 'nil' in case of error)
---@return string The previous mode, or an error message (in case of error)
function lfs.setmode(filepath, mode) end

---Identical to 'lfs.attributes' except that it obtains information about the
---link itself (not the file it refers to). It also adds a 'target' field,
---containing the file name that the symlink points to. On Windows this function
---does not yet support links, and is identical to 'lfs.attributes'.
---@param filepath string The file to read
---@param request_name? string The name of an attribute to read by itself
---@return table|nil A table with the file attributes corresponding to 'filepath' (or nil in case of error)
---@return string|nil An error message (in case of error)
---@return number|nil A system-dependent error code (in case of error)
function lfs.symlinkattributes(filepath, request_name) end

---Set access and modification times of a file. This function is a bind to
---'utime' function. The first argument is the filename, the second argument
---('atime') is the access time, and the third argument ('mtime') is the
---modification time. Both times are provided in seconds (which should be
---generated with Lua standard function 'os.time'). If the modification time is
---omitted, the access time provided is used; if both times are omitted, the
---current time is used. Returns 'true' in case of success, or 'nil', an error
---message, and a system-dependent error code in case of error.
---@param filepath string The file to change
---@param atime? number Access time, in seconds (same format as 'os.time')
---@param mtime? number Modification time, in seconds (same format as 'os.time')
---@return boolean|nil 'true' if successful (or 'nil' in case of error)
---@return string|nil An error message (in case of error)
---@return number|nil A system-dependent error code (in case of error)
function lfs.touch(filepath, atime, mtime) end

---Unlocks a file or a part of it. This function works on OPENED files; the file
---handle should be specified as the first argument. The optional arguments
---'start' and 'length' can be used to specify a starting point and its length;
---both should be numbers. Returns 'true' if the operation was successful; in
---case of error, it returns 'nil' plus an error string.
---@param filehandle userdata Handle for the file to lock
---@param start? number
---@param length? number
---@return boolean|nil 'true' if successful (or 'nil' in case of error)
---@return string|nil An error message (in case of error)
function lfs.unlock(filehandle, start, length) end

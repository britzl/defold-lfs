# Defold-LFS
This is a [Defold](https://www.defold.com) native extension for the [LuaFileSystem](http://keplerproject.github.io/luafilesystem/) library.

## System requirements
The extension does not support HTML5 but works on all other platforms where native extensions is currently supported.

## Installation
You can use Defold-LFS in your own project by adding this project as a [Defold library dependency](http://www.defold.com/manuals/libraries/). Open your game.project file and in the dependencies field under project add:

	https://github.com/britzl/defold-lfs/archive/master.zip

Or point to the ZIP file of a [specific release](https://github.com/britzl/defold-lfs/releases).

## Usage
Once you have Defold-LFS added to your project you can use lfs just like you would normally use it. Please refer to the [LuaFileSystem reference]([http://keplerproject.github.io/luafilesystem/manual.html#reference](https://web.archive.org/web/20171104164352/https://keplerproject.github.io/luafilesystem/manual.html)) for full usage instructions. Brief API overview:

	lfs.attributes (filepath [, aname | atable])
	lfs.chdir (path)
	lfs.lock_dir(path, [seconds_stale])
	lfs.currentdir ()
	iter, dir_obj = lfs.dir (path)
	lfs.lock (filehandle, mode[, start[, length]])
	lfs.link (old, new[, symlink])
	lfs.mkdir (dirname)
	lfs.rmdir (dirname)
	lfs.setmode (file, mode)
	lfs.symlinkattributes (filepath [, aname])
	lfs.touch (filepath [, atime [, mtime]])
	lfs.unlock (filehandle[, start[, length]])

## Example
There's an example in the examples folder showing a file browser implemented using Defold-LFS.

## Credits
 Graphics in example by [Kenney](http://www.kenney.nl)

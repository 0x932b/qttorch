package = "qttorch"
version = "scm-1"

source = {
   url = "git://github.com/torch/qttorch.git",
}

external_dependencies = {
   QTLUA = {
      header = "qtluaengine.h",
      library = "qtlua"
   }
}

description = {
   summary = "Qt6 interface to Torch",
   detailed = [[
      Qt6-based interface between Torch and Qt, providing tensor-image conversion
      capabilities. Requires Qt6.
   ]],
   homepage = "https://github.com/torch/qttorch",
   license = "BSD"
}

dependencies = {
   "torch >= 7.0",
   QTLUA = {
      -- First try finding local qtlua
      header = "qtluaengine.h",
      library = "qtlua",
      -- If not found, use the fork
      url = "git://github.com/0x932b/qtlua.git",
      branch = "master"  -- or whichever branch has Qt6 support
   }
}

build = {
   type = "command",
   build_command = [[
cmake -E make_directory build && cd build && cmake .. -DLUALIB=$(LUALIB) -DLUA_LIBDIR="$(LUA_LIBDIR)" -DLUADIR="$(LUADIR)" -DCMAKE_BUILD_TYPE=Release -DCMAKE_PREFIX_PATH="$(LUA_BINDIR)/..;/opt/homebrew/opt/qt@6;$(QTLUA_DIR)" -DQt6_DIR=/opt/homebrew/opt/qt@6/lib/cmake/Qt6 -DCMAKE_INSTALL_PREFIX="$(PREFIX)" && $(MAKE)
]],
   install_command = "cd build && $(MAKE) install"
}

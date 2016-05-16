# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class MedFile < Formula
  desc "MEDFile"
  homepage "unknown"
  url "http://files.salome-platform.org/Salome/other/med-3.0.7.tar.gz"
  version "3.0.7"
  sha256 "a7ff3772d2e14b50cbaf656391ba33520591e83fe35ed25ff762d15a2da678cd"
  revision 1

  option "with-python", "Build Python bindings"
  option "without-tests", "Do not build tests"

  depends_on "cmake" => :build
  depends_on "hdf5"

  #Fix cmake quoting issue
  patch :DATA

  def install
    cmake_args = std_cmake_args
    cmake_args << "-DCMAKE_PREFIX_PATH:PATH=#{HOMEBREW_PREFIX}"
    cmake_args << "-DCMAKE_INSTALL_PREFIX:PATH=#{prefix}"

    if build.with? "python"
       cmake_args << "-DMEDFILE_BUILD_PYTHON:BOOL=ON"
    end
 
    if build.without? "tests"
       cmake_args << "-DMEDFILE_BUILD_TESTS:BOOL=OFF"
    end

    system "cmake", ".", *std_cmake_args
    system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! It's enough to just replace
    # "false" with the main program this formula installs, but it'd be nice if you
    # were more thorough. Run the test with `brew test med`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "false"
  end
end

__END__
diff -ur a/config/cmake_files/medMacros.cmake b/config/cmake_files/medMacros.cmake 
--- a/config/cmake_files/medMacros.cmake	2013-10-28 08:25:20.000000000 -0700
+++ b/config/cmake_files/medMacros.cmake	2016-05-15 20:05:59.000000000 -0700
@@ -206,7 +206,7 @@
 #include <time.h>
 
 #  ifdef __cplusplus
-     extern "C"
+     extern \"C\"
 #  endif
 
 int


# Documentation: https://github.com/Homebrew/brew/blob/master/share/doc/homebrew/Formula-Cookbook.md
#                http://www.rubydoc.info/github/Homebrew/brew/master/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!

class MedFile < Formula
  desc "MEDFile - Modeling and Data Exchange standardized format"
  homepage "http://www.salome-platform.org"
  url "http://files.salome-platform.org/Salome/other/med-3.1.0.tar.gz"
  sha256 "153f825cced4387c0967fb0486bd3ee3d5b9f1820c8a8b1b44fbb2216e8b88da"
  version "3.1.0"
  revision 1

  option "with-python", "Build Python bindings"
  option "without-tests", "Do not build tests"

  depends_on "cmake" => :build
  depends_on "hdf5"

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

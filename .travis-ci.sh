# credit: http://anil.recoil.org/2013/09/30/travis-and-ocaml.html
# Edit this for your own project dependencies
OPAM_DEPENDS="ocamlfind ounit re"

case "$OCAML_VERSION,$OPAM_VERSION" in
3.12.1,1.0.0) ppa=avsm/ocaml312+opam10 ;;
3.12.1,1.1.0) ppa=avsm/ocaml312+opam11 ;;
4.00.1,1.0.0) ppa=avsm/ocaml40+opam10 ;;
4.00.1,1.1.0) ppa=avsm/ocaml40+opam11 ;;
4.01.0,1.0.0) ppa=avsm/ocaml41+opam10 ;;
4.01.0,1.1.0) ppa=avsm/ocaml41+opam11 ;;
*) echo Unknown $OCAML_VERSION,$OPAM_VERSION; exit 1 ;;
esac

echo "yes" | sudo add-apt-repository ppa:$ppa
sudo apt-get update -qq
sudo apt-get install -qq ocaml ocaml-native-compilers camlp4-extra opam gcc-multilib
sudo apt-get install -qq libc6:i386 libncurses5:i386 libstdc++6:i386 lib32z1
export OPAMYES=1
opam init
opam install ${OPAM_DEPENDS}
eval `opam config env`
./to_x86
make native-code
make byte-code
# raytracer
cd min-rt/ ; make

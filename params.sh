#!/bin/bash
# Set some default values:
ALPHA=unset
BETA=unset
CHARLIE=unset
DELTA=unset

usage()
{
  echo "Usage: k8s-setup [ -a | --alpha ] 
                        [ -b | --beta ]
                        [ -c | --charlie CHARLIE ] 
                        [ -d | --delta   DELTA   ] filename(s)"
  exit 2
}

PARSED_ARGUMENTS=$(getopt -a -n k8s-setup -o abc:d: --long alpha,beta,charlie:,delta: -- "$@")
VALID_ARGUMENTS=$?
if [ "$VALID_ARGUMENTS" != "0" ]; then
  usage
fi

echo "PARSED_ARGUMENTS is $PARSED_ARGUMENTS"
#The set command takes any arguments after the options (here “--” signals the end of the options) and assigns them to the positional parameters ($0.. $n)
eval set -- "$PARSED_ARGUMENTS"

while :
do
  case "$1" in
    -a | --alpha)   ALPHA=1      ; shift   ;;
    -b | --beta)    BETA=1       ; shift   ;;
    -c | --charlie) CHARLIE="$2" ; shift 2 ;;
    -d | --delta)   DELTA="$2"   ; shift 2 ;;
    # -- means the end of the arguments; drop this, and break out of the while loop
    --) shift; break ;;
    # If invalid options were passed, then getopt should have reported an error,
    # which we checked as VALID_ARGUMENTS when getopt was called...
    *) echo "Unexpected argument: $1 "
       usage ;;
  esac
done

echo "ALPHA   : $ALPHA"
echo "BETA    : $BETA "
echo "CHARLIE : $CHARLIE"
echo "DELTA   : $DELTA"
echo "Parameters remaining are: $@"

#!/usr/bin/env bash

cd Documentation

dot -Tpdf protocols.dot -o protocols.pdf
dot -Tpdf combinators.dot -o combinators.pdf

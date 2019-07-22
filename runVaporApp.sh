#!/bin/bash

# Compile the app
swift build

# Run the Vapor app
swift run Run serve -b 0.0.0.0

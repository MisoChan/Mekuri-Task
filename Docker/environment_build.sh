#!/bin/bash

#POSTGRES
docker run --name postgres -p 5432:5432 --restart=always -e POSTGRES_PASSWORD=postgres -itd postgres

#MONGO
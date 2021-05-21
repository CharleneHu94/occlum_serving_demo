#!/bin/bash

curl -d \
'{
  "instances": [
      {
            "image": "/9j/4AAQSkZJRgABAQEASABIAAD/7RcEUGhvdG9za..."
      },   
   ]
}' \
-X POST http://127.0.0.1:10020/predict

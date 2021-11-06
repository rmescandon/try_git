#!/usr/bin/env python3
#
# Copyright (C) 2020 Roberto Mier Escandon <rmescandon@gmail.com>
#

from fastapi import FastAPI

app = FastAPI()


@app.get("/")
async def root():
    return {"message": "Hello World"}

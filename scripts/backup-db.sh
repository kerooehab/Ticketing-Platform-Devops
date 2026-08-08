import os
from flask import Flask, jsonify

app = Flask(__name__)

PORT = int(os.environ.get("PORT", 5000))

@app.route("/health", methods=["GET"])
def health_check():
    return jsonify({"status": "OK"}), 200

@app.route("/", methods=["GET"])
def index():
    return jsonify({"message": "Welcome to the Backend API"}), 200

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=PORT)

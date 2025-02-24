## Search your code with AIDA

This feature of Harness AI Development Assistant (AIDA) allows developers to quickly find and understand code across their repositories. It provides an AI-powered, context-aware search capability that helps users locate specific functions, variables, or logic without manually scanning large codebases.</br>
</br>
It uses the Semantic Code Search functionality to search your entire codebase using natural language queries. Ask a question and let AIDA retrieve source code that best answers your question. This is useful when you aren't sure what specific keywords to search for or you want to better understand what the code achieves.
### Natural language processing
With Semantic Code Search enabled, AIDA treats your search query as a natural language question and searches for code that matches the semantic meaning of your question, rather than looking for specific keywords or regular expressions. More detailed questions allow AIDA to provide more refined results.

### Search Question Examples: 
- Where is the code that handles authentication?
- Where is the application entry point?
- Where do we configure the logger?
- What repositories does the group 'platform-devs' own code in?

![searcho-code](https://github.com/vivekraj601/Harness/blob/0653b2cc59b33e835827c2bee00db3874fd3b818/harness-AI/media/search.png)

</br>

![searcho-code](https://github.com/vivekraj601/Harness/blob/9d09fcd967ebd19cc53ce188a5f6c003544c587b/harness-AI/media/search2.png)


### Let's assume we have a Flask app with authentication and Redis caching. 

Main Application (app.py)

```python
from flask import Flask, request, jsonify
import redis
from auth import authenticate_user

app = Flask(__name__)

# Initialize Redis cache
cache = redis.Redis(host='localhost', port=6379, db=0)

@app.route('/login', methods=['POST'])
def login():
    data = request.json
    user = authenticate_user(data['username'], data['password'])
    if user:
        cache.set(user['id'], 'logged_in')
        return jsonify({"message": "Login successful"})
    return jsonify({"error": "Invalid credentials"}), 401

if __name__ == '__main__':
    app.run(debug=True)

```

Authentication Logic (auth.py)
```python
import bcrypt

# Simulated user database
users_db = {
    "admin": {"password_hash": bcrypt.hashpw(b"password", bcrypt.gensalt())}
}

def authenticate_user(username, password):
    if username in users_db:
        stored_hash = users_db[username]["password_hash"]
        if bcrypt.checkpw(password.encode(), stored_hash):
            return {"id": username}
    return None


```
## How Hanress AI search helps:
Query 1: "Where is user authentication handled?"
```bash
Harness AI Response:

File: auth.py
Function: authenticate_user()
Usage: Found in app.py under /login route
```
Query 2: "Where do we use Redis caching?"
```bash
Harness AI Response:

File: app.py
Line 6: cache = redis.Redis(host='localhost', port=6379, db=0)
Usage: cache.set(user['id'], 'logged_in') in /login route.
```

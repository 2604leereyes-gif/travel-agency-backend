# 🚀 Rails API + MySQL Setup Guide (Pinned Versions)

This project is a Rails API backend using MySQL.

---

## 📦 Tech Stack

- Ruby: 3.2.3  
- Rails: 7.1.x  
- MySQL: 8.0.x  
- Bundler: 2.4+

---

## 🐧 Setup (Linux / macOS)

### 1. Install dependencies

sudo apt update
sudo apt install -y build-essential libssl-dev libreadline-dev zlib1g-dev libyaml-dev libffi-dev libxml2-dev libxslt1-dev default-libmysqlclient-dev pkg-config

---

### 2. Install Ruby (rbenv)

git clone https://github.com/rbenv/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init - bash)"' >> ~/.bashrc
source ~/.bashrc

git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build

rbenv install 3.2.3
rbenv global 3.2.3

---

### 3. Install Rails

gem install bundler -v 2.4.22
gem install rails -v 7.1.3
rbenv rehash

---

### 4. Install MySQL

sudo apt install -y mysql-server
sudo systemctl enable mysql
sudo systemctl start mysql

mysql --version

---

## 🚀 Create Rails API

rails new myapp --api -d mysql
cd myapp
bundle install

---

## 🗄️ Setup database

rails db:create
rails db:migrate

---

## ▶️ Run server

rails s

Open:
http://localhost:3000

---

## 🪟 Windows (WSL2)

Use Ubuntu WSL2 ONLY.

Follow same Linux steps.

---

## ⚠️ Common fixes

### mysql2 error
sudo apt install -y default-libmysqlclient-dev

### yaml / psych error
sudo apt install -y libyaml-dev

### port 3306 conflict
sudo lsof -i :3306
sudo systemctl stop mysql

---

## 📌 Example API

rails g scaffold Post title:string body:text
rails db:migrate

---

## Endpoints

GET /posts  
POST /posts  
GET /posts/:id  
PUT /posts/:id  
DELETE /posts/:id

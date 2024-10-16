require 'sqlite3'

db = SQLite3::Database.new 'db/development.sqlite3'

rows = db.execute <<-SQL
  CREATE TABLE IF NOT EXISTS mountains (
    id INTEGER PRIMARY KEY,
    title VARCHAR(255),
    name VARCHAR(255),
    altitude INT,
    description TEXT
  );
SQL

DB = SQLite3::Database.new 'db/development.sqlite3'
DB.execute("INSERT INTO mountains (title, name, altitude, description) VALUES (?, ?, ?, ?)", ['Mont Blanc', 'mont-blanc', 4809, "Le mont Blanc (en italien : Monte Bianco), dans le massif du Mont-Blanc, est le point culminant de la chaîne des Alpes. Avec une altitude de 4 806 mètres, il est le plus haut sommet d'Europe occidentale et de l'Union européenne ainsi que le sixième sur le plan continental en prenant en compte les montagnes du Caucase, dont l'Elbrouz (5 643 mètres) est le plus haut sommet. Il se situe sur la frontière franco-italienne, entre le département de la Haute-Savoie (en France) et la région autonome de la Vallée d'Aoste (en Italie) ; cette frontière est l'objet d'un litige historique entre les deux pays."])
DB.execute("INSERT INTO mountains (title, name, altitude, description) VALUES (?, ?, ?, ?)", ['Cervin', 'cervin', 4478, "Le Cervin (en allemand : Matterhorn, en italien : Cervino) est, par son altitude de 4 478 mètres, le 12e sommet des Alpes. Il est situé sur la frontière italo-suisse, entre le canton du Valais et la Vallée d'Aoste. Il donne sur la ville suisse de Zermatt au nord-est et la ville italienne de Breuil-Cervinia au sud. Il relie la vallée de Zermatt et le Valtournenche, en Vallée d'Aoste, par le col de Saint-Théodule, à l’est."])

puts "Database and table set up successfully!"

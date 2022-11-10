User.create!(email: "kate@god.win", password: "goodbye")
User.create!(email: "mike@wild.er", password: "goodbye")

Project.create!(due_date: "10/4/2022", name: "Jones Wedding", kind: "wedding invites", user_id: 1)
Project.create!(due_date: "10/5/2023", name: "James Wedding", kind: "wedding invites", user_id: 2)

Milestone.create!(due_date: "09/04/2022", name: "ship invites", description: "invites must be shipped by this date", project_id: 1)
Milestone.create!(due_date: "06/04/2022", name: "present proofs", description: "give customer time to review and suggest changes", project_id: 1)
Milestone.create!(due_date: "05/05/2022", name: "present proofs", description: "give customer time to review and suggest changes", project_id: 2)
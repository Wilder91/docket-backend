User.create!(name: "Kate Godwin", email: "kate@god.win", password: "goodbye")
User.create!(name: "Mike Wilder", email: "michael@wil.der", password: "goodbye")

Project.create!(due_date: "10/4/2024", name: "Jones Wedding", kind: "wedding invites", complete: false,  user_id: 1)
Project.create!(due_date: "10/5/2025", name: "James Wedding", kind: "wedding invites",  complete: false, user_id: 2)

Milestone.create!(due_date: "09/04/2024", lead_time: 30, name: "ship invites", description: "invites must be shipped by this date", complete: true, project_id: 1)
Milestone.create!(due_date: "06/04/2024", lead_time:  122,name: "present proofs", description: "give customer time to review and suggest changes", complete: false, project_id: 1)
Milestone.create!(due_date: "05/05/2025", lead_time: 518, name: "present proofs", description: "give customer time to review and suggest changes", complete: false, project_id: 2)
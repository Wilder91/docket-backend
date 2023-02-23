User.create!(name: "Kate Godwin", email: "kate@god.win", password: "goodbye")
User.create!(name: "Mike Wilder", email: "michael@wild.er", password: "goodbye")

Project.create!(due_date: "10/4/2022", name: "Jones Wedding", kind: "wedding invites", template: false, complete: false,  user_id: 1)
Project.create!(due_date: "10/5/2023", name: "James Wedding", kind: "wedding invites", template: false, complete: false, user_id: 2)

Milestone.create!(due_date: "09/04/2022", lead_time: 30, name: "ship invites", description: "invites must be shipped by this date", complete: true, project_id: 1)
Milestone.create!(due_date: "06/04/2022", lead_time:  122,name: "present proofs", description: "give customer time to review and suggest changes", complete: false, project_id: 1)
Milestone.create!(due_date: "05/05/2022", lead_time: 518, name: "present proofs", description: "give customer time to review and suggest changes", complete: false, project_id: 2)
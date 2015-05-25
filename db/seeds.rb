User.create({ email:        "joe@example.com",
              password:     "sampletest123",
              title:        "Mr",
              first_names:  "Joe",
              middle_names: "von",
              last_names:   "Tester",
              dob:          Date.parse("1967-03-21") })

User.create({ email:        "sue@example.com",
              password:     "sampletest123",
              title:        "Ms",
              first_names:  "Sue",
              last_names:   "Fixture",
              dob:          Date.parse("1973-05-12") })

User.create({ email:        "foo@example.com",
              password:     "sampletest123",
              title:        "Dr",
              first_names:  "Foo",
              last_names:   "Bar",
              dob:          Date.parse("1988-05-09") })

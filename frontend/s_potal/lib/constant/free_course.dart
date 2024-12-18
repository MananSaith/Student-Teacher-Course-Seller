class CourseData {
  static List<Map<String, dynamic>> courses = [
    {
      "title": "Artificial Intelligence (AI)",
      "description":
          "Explore the fascinating world of Artificial Intelligence and learn how machines simulate human intelligence.",
      "headings": [
        {
          "title": "Introduction to AI",
          "content":
              "Understand the core concepts of AI, including its history, significance, and applications in today's world.",
        },
        {
          "title": "Machine Learning Basics",
          "content":
              "Dive into the basics of machine learning, covering supervised and unsupervised learning models.",
        },
        {
          "title": "AI in Everyday Life",
          "content":
              "Discover real-world applications of AI, from smart assistants to autonomous vehicles.",
        },
      ],
      "details":
          "Artificial Intelligence (AI) is one of the most transformative technologies of the 21st century. This course provides an in-depth understanding of how AI works, its practical applications, and the ethical challenges it poses. You'll learn about neural networks, decision trees, and other algorithms that power modern AI systems. Whether you're interested in natural language processing, computer vision, or robotics, this course covers the essential knowledge to get started in the field of AI.",
      "image": "assets/courseImage/ai.jpg"
    },
    {
      "title": "Machine Learning (ML)",
      "description":
          "Master the fundamentals of Machine Learning and build predictive models for various real-world applications.",
      "headings": [
        {
          "title": "Supervised Learning",
          "content":
              "Learn how to train models with labeled data to make predictions and classifications.",
        },
        {
          "title": "Unsupervised Learning",
          "content":
              "Understand techniques to identify patterns in data without explicit labels, like clustering and dimensionality reduction.",
        },
        {
          "title": "Reinforcement Learning",
          "content":
              "Explore how agents learn to make decisions by interacting with their environment.",
        },
      ],
      "details":
          "Machine Learning is the science of teaching computers to learn from data. This course takes you from the basics of regression and classification to advanced topics like neural networks and ensemble methods. Through hands-on projects, you'll gain practical experience in building machine learning models using popular tools like Python and TensorFlow. The course also covers the evaluation and optimization of models to improve accuracy and performance.",
      "image": "assets/courseImage/ml.jpg"
    },
    {
      "title": "Data Science",
      "description":
          "Learn how to extract insights from data and make data-driven decisions using cutting-edge tools and techniques.",
      "headings": [
        {
          "title": "Data Collection and Cleaning",
          "content":
              "Discover methods to gather, clean, and preprocess data for analysis.",
        },
        {
          "title": "Exploratory Data Analysis (EDA)",
          "content":
              "Learn how to analyze and visualize data to uncover patterns and trends.",
        },
        {
          "title": "Data Visualization",
          "content":
              "Master tools like Matplotlib and Tableau to create stunning visualizations.",
        },
      ],
      "details":
          "Data Science combines programming, mathematics, and domain expertise to analyze and interpret complex data. This course provides a complete journey, from data collection to creating actionable insights. You'll learn key concepts like probability, statistics, and machine learning algorithms to work effectively with data. By the end of the course, you'll have built multiple projects, including predictive models and interactive dashboards.",
      "image": "assets/courseImage/ds.jpg"
    },
    {
      "title": "Blockchain Technology",
      "description":
          "Dive into the decentralized world of blockchain and learn how it revolutionizes industries.",
      "headings": [
        {
          "title": "What is Blockchain?",
          "content":
              "Understand the basics of blockchain, its structure, and how it ensures security and transparency.",
        },
        {
          "title": "Smart Contracts",
          "content":
              "Learn about self-executing contracts that run on blockchain platforms.",
        },
        {
          "title": "Cryptocurrencies",
          "content":
              "Explore popular cryptocurrencies like Bitcoin and Ethereum, and how they leverage blockchain technology.",
        },
      ],
      "details":
          "Blockchain is a distributed ledger technology that enables secure and transparent transactions. This course covers the architecture of blockchain, consensus mechanisms, and its real-world applications. You'll also get hands-on experience building a blockchain and deploying smart contracts using Solidity on Ethereum. Whether you're interested in cryptocurrencies or enterprise solutions, this course provides the foundation you need to excel in blockchain technology.",
      "image": "assets/courseImage/bc.jpg"
    },
    {
      "title": "Mobile Development",
      "description":
          "Build mobile apps for Android and iOS using modern frameworks and tools.",
      "headings": [
        {
          "title": "Introduction to Mobile Development",
          "content":
              "Understand the mobile app ecosystem and the differences between Android and iOS platforms.",
        },
        {
          "title": "Cross-Platform Development",
          "content":
              "Learn how to create apps using frameworks like Flutter and React Native.",
        },
        {
          "title": "Publishing Apps",
          "content":
              "Master the steps to publish your app on Google Play Store and Apple App Store.",
        },
      ],
      "details":
          "Mobile app development is a crucial skill in today's digital age. This course teaches you how to design, develop, and deploy mobile applications for Android and iOS. You'll work with Flutter to create stunning cross-platform apps. The course also covers UI/UX principles, testing, and publishing your app on major app stores. By the end, you'll have a portfolio of apps showcasing your skills.",
      "image": "assets/courseImage/md.jpg"
    },
    {
      "title": "Web Development",
      "description":
          "Learn how to create stunning and responsive websites using modern technologies.",
      "headings": [
        {
          "title": "Frontend Development",
          "content":
              "Learn HTML, CSS, and JavaScript to design beautiful user interfaces.",
        },
        {
          "title": "Backend Development",
          "content":
              "Understand how to create robust server-side applications using Node.js.",
        },
        {
          "title": "Full-Stack Development",
          "content":
              "Combine frontend and backend skills to build complete web applications.",
        },
      ],
      "details":
          "Web development involves creating interactive and functional websites. This course covers frontend, backend, and full-stack development. You'll learn to use popular tools like React, Express.js, and MongoDB to build scalable web applications. The course also includes deployment strategies, ensuring your web apps are accessible to a global audience.",
      "image": "assets/courseImage/wd.jpg"
    },
    {
      "title": "Cloud Computing",
      "description":
          "Learn the fundamentals of cloud computing and how to leverage cloud platforms like AWS, Azure, and Google Cloud.",
      "headings": [
        {
          "title": "Introduction to Cloud Computing",
          "content":
              "Understand the concept of cloud computing, its service models (IaaS, PaaS, SaaS), and deployment models (private, public, hybrid).",
        },
        {
          "title": "Cloud Platforms and Tools",
          "content":
              "Explore various cloud platforms, including AWS, Microsoft Azure, and Google Cloud, and learn how to use them for development.",
        },
        {
          "title": "Cloud Security",
          "content":
              "Learn how to secure cloud-based applications, manage data privacy, and understand compliance standards.",
        },
      ],
      "details":
          "Cloud computing allows businesses and individuals to store and access data over the internet. This course teaches you how to utilize the cloud to build scalable applications, store data securely, and manage infrastructure efficiently. You'll explore leading cloud platforms and gain hands-on experience setting up cloud environments, managing resources, and deploying applications.",
      "image": "assets/courseImage/cc.jpg"
    },
    {
      "title": "Cybersecurity",
      "description":
          "Protect information and systems from cyber threats in this comprehensive course on cybersecurity.",
      "headings": [
        {
          "title": "Network Security",
          "content":
              "Learn how to secure networks from unauthorized access, attacks, and other vulnerabilities.",
        },
        {
          "title": "Encryption and Authentication",
          "content":
              "Understand the basics of encryption and how to authenticate users and devices securely.",
        },
        {
          "title": "Security in the Cloud",
          "content":
              "Learn about securing data and applications in cloud environments, including identity and access management (IAM).",
        },
      ],
      "details":
          "Cybersecurity is the practice of protecting systems, networks, and programs from digital attacks. In this course, you'll learn about various security protocols, risk management, encryption techniques, and ethical hacking. You'll gain hands-on experience securing networks, managing vulnerabilities, and developing strategies to respond to security incidents.",
      "image": "assets/courseImage/cs.jpg"
    },
  ];
}

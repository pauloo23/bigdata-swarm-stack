# Big Data Platform on Docker Swarm

This repository facilitates the deployment of a comprehensive and scalable big data platform orchestrated entirely within Docker Swarm. It provides a ready-to-use environment for data engineers and enthusiasts looking to manage, process, analyze, and visualize data using a collection of industry-standard open-source tools.

**Project Explanation**

The core idea behind this project is to demonstrate how to build a functional data platform using the container orchestration capabilities of Docker Swarm. Instead of relying on more complex orchestration systems like Kubernetes, this project showcases the power and simplicity of Docker Swarm for managing distributed data workloads.

The platform is architected in distinct layers, each addressing a specific stage of the data lifecycle:

* **Storage Layer:** Utilizes MinIO, an S3-compatible object storage, to provide a scalable and reliable foundation for storing large datasets. Integrated with MinIO is Delta Lake, which brings ACID properties and advanced features like time travel to the data lake, ensuring data integrity and enabling more robust data pipelines.

* **Data Processing Layer:** Employs Apache Spark, a powerful distributed computing engine, for processing and transforming data at scale. The execution of Spark jobs is orchestrated by Apache Airflow, a workflow management platform that allows for programmatic scheduling, monitoring, and authoring of data pipelines.

* **Query and Analytics Layer:** Leverages Apache Hive as a data warehouse system, providing a SQL-like interface for querying and analyzing large volumes of data stored in MinIO/Delta Lake. Trino, a fast distributed SQL query engine, is also included for high-performance interactive analytics on the same data.

* **Data Visualization Layer:** Features Apache Superset, a modern data exploration and visualization platform, enabling users to create interactive dashboards and gain insights from the processed and queried data.

This project includes a practical example demonstrating a simple ETL (Extract, Transform, Load) process, showcasing how data can flow seamlessly through these different layers. It serves as a valuable learning resource and a foundation that can be adapted for various data processing and analysis needs in development environments.

**Repository Contents (High-Level):**

* **Docker Orchestration Files:** `docker-compose.yml` (for the main platform), `swarmpit.yml` (for Swarm monitoring).
* **Custom Docker Image Definitions:** Located in the `Dockerfiles/` directory.
* **Build Automation:** `build-images.sh` script for building and publishing custom Docker images.
* **Airflow Workflow Examples:** Sample DAG files in the `dags/` directory.
* **Jupyter Notebook and Sample Data:** Located in the `work/` directory for demonstrating the ETL process.

**For a comprehensive, step-by-step guide on deploying and utilizing this data platform, please refer to the full article on Medium:**

[**[Insert Link to Your Medium Article Here]**](YOUR_MEDIUM_ARTICLE_LINK_HERE)

**Author**

<a href="https://www.linkedin.com/in/paulodpbarbosa/" target="_blank">
  <img src="https://cdn-icons-png.flaticon.com/128/145/145807.png" alt="LinkedIn" width="16" style="vertical-align:middle;" />
  Paulo Barbosa
</a>

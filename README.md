# Homelab Project with Termux

This project is aimed at running a homelab on an old Android phone using Termux. It includes several components such as Airflow, some automation tools written in Rust, and a dashboard for monitoring things.

<table>
    <tr>
        <td>
            <img src="./screenshot/_DSC3625.png" />
        </td>
        <td>
            <img src="./screenshot/_DSC3637.png" />
        </td>
    </tr>
</table>

# Installation

## Option 1: Termux on your old Android Phone

- Install Termux
- Install Deb on Termux: https://github.com/sp4rkie/debian-on-termux
- Refer to the scripts folder. It contains all the necessary scripts and instructions for setting up the components.

## Option 2: MacOS - Docker Compose

- Put this project to iCloud Drive so data mount at `./icloud` (ignored by `.gitignore`) can be backup automatically.
- Recommended using https://orbstack.dev for lightweight docker.

```bash
docker-compose up
```


# Components

## Airflow

Airflow is a platform to programmatically author, schedule, and monitor workflows. It provides an easy-to-use UI and a rich set of operators for creating complex workflows.

## Automation Tools

The project includes some automation tools written in Rust. These tools can be used to automate various tasks, such as file management, data processing, and more.

## ClickHouse

For keep track everything data.

## Grafana

The dashboards for monitoring the various components of the homelab. It provides real-time information about the status of each component and allows for easy management of the homelab.

# License

MIT.

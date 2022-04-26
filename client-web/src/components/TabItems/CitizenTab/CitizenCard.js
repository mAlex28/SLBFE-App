import React from 'react'
import {
  Card,
  CardHeader,
  CardActions,
  CardContent,
  Avatar,
  Typography,
  IconButton,
  Button,
} from '@mui/material'
import DoneIcon from '@mui/icons-material/Done'
import PhoneInTalkIcon from '@mui/icons-material/PhoneInTalk'
import EmailIcon from '@mui/icons-material/Email'
import CloseIcon from '@mui/icons-material/Close'
import { red } from '@mui/material/colors'
import { Link, useNavigate } from 'react-router-dom'

const CitizenCard = ({ citizen }) => {
  const navigate = useNavigate()

  const viewCitizen = (e) => {
    navigate(`/citizen/${citizen._id}`)
  }

  return (
    <Card
      elevation={5}
      sx={{
        width: '80%',
        padding: '10px',
        marginTop: '20px',
        marginBottom: '10px',
      }}
    >
      <CardHeader
        onClick={viewCitizen}
        avatar={
          citizen.profilePic ? (
            <Avatar
              alt={citizen.name}
              src={citizen.profilePic}
              aria-label="avatar"
            />
          ) : (
            <Avatar sx={{ bgcolor: red[500] }} aria-label="avatar">
              {citizen.name.charAt(0)}
            </Avatar>
          )
        }
        action={
          citizen.isVerified ? (
            <Button
              variant="outlined"
              color="success"
              startIcon={
                <DoneIcon
                  sx={{
                    color: '#4caf50',
                  }}
                />
              }
            >
              Verified
            </Button>
          ) : (
            <Button
              variant="outlined"
              color="warning"
              startIcon={
                <CloseIcon
                  sx={{
                    color: '#4caf50',
                  }}
                />
              }
            >
              Not Verified
            </Button>
          )
        }
        title={citizen.name}
        subheader={citizen.profession}
      />
      <CardContent>
        <Typography variant="body2" color="text.secondary">
          {citizen.description.split(' ').splice(0, 20).join(' ')}...
        </Typography>
      </CardContent>
      <div
        style={{
          display: 'flex',
          justifyContent: 'space-between',
          margin: '20px',
        }}
      >
        <Typography variant="body2" color="GrayText" component="p">
          {citizen.qualifications.map((qualification) => `#${qualification} `)}
        </Typography>
      </div>
      <CardActions disableSpacing>
        <Link
          to="#"
          onClick={() => (window.location.href = `mailto:${citizen.contact}`)}
        >
          <IconButton aria-label="call">
            <PhoneInTalkIcon />
          </IconButton>
        </Link>
        <Link
          to="#"
          onClick={() => (window.location.href = `tel:${citizen.email}`)}
        >
          <IconButton aria-label="email">
            <EmailIcon />
          </IconButton>
        </Link>
      </CardActions>
    </Card>
  )
}

export default CitizenCard

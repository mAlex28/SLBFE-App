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

const CitizenCard = () => {
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
        avatar={
          <Avatar sx={{ bgcolor: red[500] }} aria-label="recipe">
            R
          </Avatar>
        }
        action={
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
        }
        title="Perera Sons"
        subheader="Software Engineer"
      />
      <CardContent>
        <Typography variant="body2" color="text.secondary">
          This impressive paella is a perfect party dish and a fun meal to cook
          together with your guests. Add 1 cup of frozen peas along with the
          mussels, if you like.
        </Typography>
      </CardContent>
      <CardActions disableSpacing>
        <IconButton aria-label="add to favorites">
          <PhoneInTalkIcon />
        </IconButton>
        <IconButton aria-label="share">
          <EmailIcon />
        </IconButton>
      </CardActions>
    </Card>
  )
}

export default CitizenCard

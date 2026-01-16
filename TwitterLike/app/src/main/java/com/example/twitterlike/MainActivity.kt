package com.example.twitterlike

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.activity.enableEdgeToEdge
import androidx.compose.foundation.Image
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.rememberScrollState
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.foundation.verticalScroll
import androidx.compose.material.icons.Icons
import androidx.compose.material.icons.filled.Favorite
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.Icon
import androidx.compose.material3.IconButton
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Text
import androidx.compose.material3.TopAppBar
import androidx.compose.material3.TopAppBarDefaults
import androidx.compose.runtime.Composable
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.layout.ContentScale
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import com.example.twitterlike.ui.theme.TwitterLikeTheme

class MainActivity : ComponentActivity() {
    @OptIn(ExperimentalMaterial3Api::class)
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContent {
            TwitterLikeTheme {
                Scaffold(modifier = Modifier.fillMaxSize(), topBar = {
                    TopAppBar(
                        colors = TopAppBarDefaults.topAppBarColors(
                            containerColor = MaterialTheme.colorScheme.primaryContainer,
                            titleContentColor = MaterialTheme.colorScheme.primary,
                        ),
                        title = {
                            Text(
                                "こんぶ @ Flutter大学",
                                fontWeight = FontWeight.Bold,
                                fontSize = 30.sp
                            )
                        }
                    )
                }) { innerPadding ->
                    AvatarCardView(Modifier.padding(innerPadding))
                }
            }
        }
    }
}

@Composable
fun AvatarCardView(modifier: Modifier = Modifier) {
    val state = rememberScrollState()
    Column(
        modifier
            .padding(8.dp)
            .verticalScroll(state)
    ) {
        TweetTile()
        TweetTile()
        TweetTile()
        TweetTile()
        TweetTile()
        TweetTile()
        TweetTile()
        TweetTile()
        TweetTile()
        TweetTile()
    }
}

@Composable
fun TweetTile(modifier: Modifier = Modifier) {
    Row(modifier = modifier, verticalAlignment = Alignment.CenterVertically) {
        Image(
            modifier = Modifier
                .size(50.dp)
                .clip(RoundedCornerShape(16.dp)),
            painter = painterResource(R.drawable.dog),
            contentScale = ContentScale.Fit,
            contentDescription = "Artist image"
        )
        Spacer(modifier = Modifier.width(8.dp))
        Column {
            Row {
                Text("こんぶ @ Flutter大学")
                Spacer(modifier = Modifier.height(8.dp))
                Text("2022/05/05")
            }
            Spacer(modifier = Modifier.height(4.dp))
            Text("最高でした。")
            IconButton(onClick = {}) {
                Icon(imageVector = Icons.Filled.Favorite, contentDescription = "Favorite")
            }
        }
    }
}
